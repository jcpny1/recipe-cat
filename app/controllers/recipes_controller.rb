# Rails controller for Recipe model.
class RecipesController < ApplicationController
  skip_after_action :verify_authorized,    only: :updated_after
  after_action      :verify_policy_scoped, only: :updated_after

  # save the selected ingredient filter value(s) for later display use.
  def filter
    skip_authorization
    session[:ingredient_filter] = params[:recipe_ingredient][:ingredient]
    redirect_to request.referer
  end

  # Return the recipe corresonding to the previous or next id in the session[:recipe_id_list].
  def navigate
    skip_authorization
    current_recipe_id = params[:id].to_i
    current_recipe_index = session[:recipe_id_list].find_index(current_recipe_id)
    if current_recipe_index
      direction = params[:direction]
      if (direction == 'next') && (current_recipe_index < session[:recipe_id_list].length - 1)
        current_recipe_id = session[:recipe_id_list][current_recipe_index + 1]
      elsif (direction == 'prev') && (current_recipe_index > 0)
        current_recipe_id = session[:recipe_id_list][current_recipe_index - 1]
      end
    end
    @recipe = Recipe.find(current_recipe_id)
    respond_to do |format|
      format.html { render @recipe }
      format.json { render json: @recipe }
    end
  end

  # display recipes created or updated after the specified date.
  def updated_after
    update_selector {
      @recipes = policy_scope(Recipe.updated_after(@date)).order(:name) }
    render :index
  end

  # display all recipes.
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
    session[:recipe_id_list] = @recipes.map{ |recipe| recipe.id }
    @user_name = user.email if user
  end

  # display a specific recipe.
  def show
    @recipe = Recipe.find_by(id: params[:id])
    authorize @recipe
  end

  # prepare to create a new recipe.
  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.new
    @recipe.recipe_steps.new(step_number: '1')
    authorize @recipe
  end

  # create a new recipe and save it to the database.
  def create
    @recipe = current_user.recipes.new(recipe_params)
    @recipe.name = @recipe.name.titleize
    authorize @recipe
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:alert] = @recipe.errors.full_messages
      render :new
    end
  end

  # edit a recipe.
  def edit
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.recipe_ingredients.new if @recipe.recipe_ingredients.length == 0
    @recipe.recipe_steps.new(step_number: '1') if @recipe.recipe_steps.length == 0
    authorize @recipe
  end

  # commit recipe edits to the database.
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

  # delete a recipe.
  def destroy
    recipe_id = params[:id]
    recipe = Recipe.find_by(id: recipe_id)
    authorize recipe
    session[:recipe_id_list].delete(recipe_id)
    recipe.destroy
    redirect_to user_recipes_path(current_user)
  end

private

  # filter params for allowed elements only.
  def recipe_params
    params.require(:recipe).permit(:name, :description, :total_time,
      recipe_ingredients_attributes: [:id, :ingredient_id, :quantity, :unit_id, :_destroy],
      recipe_steps_attributes: [:id, :step_number, :step_number, :description, :_destroy])
  end
end
