class RecipeIngredientsController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index # render a list of @recipe_ingredients ordered by ingredient name.
    recipe_ingredients = RecipeIngredient.where(recipe_id: params[:recipe_id])

    @recipe_ingredients = recipe_ingredients.sort { |recipe_ingredient_1,recipe_ingredient_2|
      recipe_ingredient_1.recipe.name <=> recipe_ingredient_2.recipe.name
    }
    @recipe_name = Recipe.find_by(id: params[:recipe_id]).name
  end

  def create   # only setting ingredient_filter here.
    session[:ingredient_filter] = params[:recipe_ingredient][:ingredient]
    redirect_to recipes_path
  end
end
