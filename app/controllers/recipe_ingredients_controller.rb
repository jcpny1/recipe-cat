class RecipeIngredientsController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @recipe_ingredients = RecipeIngredient.where(recipe_id: params[:recipe_id])
    @recipe_name = Recipe.find_by(id: params[:recipe_id]).name
  end

  def new
    recipe = Recipe.find_by(id: params[:recipe_id])
    authorize recipe
    @recipe_ingredient = recipe.recipe_ingredients.new
    @recipe_name = recipe.name
  end

  def create
    recipe = Recipe.find_by(id: params[:recipe_id])
    authorize recipe
    @recipe_ingredient = recipe.recipe_ingredients.new(ingredient_id: params[:recipe_ingredient][:ingredient], quantity: params[:recipe_ingredient][:quantity], unit_id: params[:recipe_ingredient][:unit])
    if recipe.save
      redirect_to recipe
    else
      flash[:alert] = @recipe_ingredient.errors.full_messages
      @recipe_name = recipe.name
      render :new
    end
  end

  def filter   # only setting ingredient_filter value here.
    session[:ingredient_filter] = params[:recipe_ingredient][:ingredient]
    redirect_to recipes_path
  end

  def destroy
    recipe = Recipe.find_by(id: params[:recipe_id])
    recipe.recipe_ingredients.destroy(params[:id])
    redirect_to recipe_path(recipe)
  end
end
