class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action  :verify_policy_scoped, only: :index  # seems like verify doesn't recognize a custom scope function.

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @recipes = RecipePolicy::Scope.new(@user, Recipe).user_only.order(:name)
      @user_recipes = true
    else
      @recipes = policy_scope(Recipe).order(:name)
    end
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
    @recipe.photo_path = 'recipes/placeholder.png'
    authorize @recipe
    if @recipe.save
      redirect_to @recipe
    else
      flash[:alert] = @recipe.errors.full_messages
      render :new
    end
  end

private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :total_time)
  end

end
