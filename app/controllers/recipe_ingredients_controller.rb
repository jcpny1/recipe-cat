class RecipeIngredientsController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @recipe_ingredients = RecipeIngredient.where(recipe_id: params[:recipe_id])
    @recipe_name = Recipe.find_by(id: params[:recipe_id]).name
  end

  def new
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe.recipe_ingredients.create(ingredient_id: 2, unit_id:2)
    render 'recipes/show'
  end

  def create   # only setting ingredient_filter here.
    session[:ingredient_filter] = params[:recipe_ingredient][:ingredient]
    redirect_to recipes_path
  end

  def destroy
    recipe = Recipe.find_by(id: params[:recipe_id])
    recipe.recipe_ingredients.destroy(params[:id])
    redirect_to recipe_path(recipe)
  end
end
