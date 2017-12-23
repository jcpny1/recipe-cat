# Rails contoller for RecipeIngredient model.
class RecipeIngredientsController < ApplicationController
  def index
    @recipe_ingredients = RecipeIngredient.sort_by_ingredient_name(policy_scope(RecipeIngredient.where('recipe_id = ?', params[:recipe_id])).order(:ingredient_id))
    render json: @recipe_ingredients, include: %w[ingredient unit]
  end
end
