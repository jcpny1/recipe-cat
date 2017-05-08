class RecipesController < ApplicationController
  skip_after_action :verify_authorized,    only: :updated_after
  after_action      :verify_policy_scoped, only: :updated_after

  def filter   # only setting ingredient_filter value here.
    skip_authorization
    session[:ingredient_filter] = params[:recipe_ingredient][:ingredient]
    redirect_to request.referer
  end

  def renumber_steps   # renumber recipe steps.
    @recipe = Recipe.find_by(id: params[:id])
    authorize @recipe
    RecipeStep.renumber(@recipe.recipe_steps)
    redirect_to request.referer
  end

  def updated_after   # list recipes created or updated after the specified date.
    @date = params[:date]
    @recipes = policy_scope(Recipe.updated_after(@date)).order(:name)
    @updated_after = true
    render :index
  end

  def index
    @recipes = policy_scope(Recipe).order(:name)  # get recipes user is entitled to see.

    if params[:user_id].present?
      @recipes = Recipe.filter_array_by_user(@recipes, params[:user_id])  # reduce recipe list to just optional specified owner.
      user = User.find(params[:user_id])
      @user_recipes = true
    else
      user = current_user
    end

    @recipes = Recipe.filter_array_by_ingredient(@recipes, session[:ingredient_filter]) if session[:ingredient_filter].present?  # filter by ingredient, if necessary.
    @user_name = user.email if user
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    authorize @recipe
  end

  def new
    @recipe = Recipe.new
    authorize @recipe
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    authorize @recipe
    @recipe.total_time ||= 0
    @recipe.photo_path = 'recipes/placeholder.png'
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:alert] = @recipe.errors.full_messages
      render :new
    end
  end

  def edit
    @recipe = Recipe.find_by(id: params[:id])
    authorize @recipe
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    authorize @recipe
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash.now[:alert] = @recipe.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    recipe = Recipe.find_by(id: params[:id])
    authorize recipe
    recipe.destroy
    redirect_to request.referer
  end

private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :total_time)
  end

end
