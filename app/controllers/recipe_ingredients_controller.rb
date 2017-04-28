class RecipeIngredientsController < ApplicationController
  def create
    ingredient_id = params[:recipe_ingredient][:ingredient]

# do a join in where instead of manually getting recipes
    recipe_ingredients = RecipeIngredient.where(ingredient_id: ingredient_id)

    recipe_list = recipe_ingredients.collect { |ri| ri.recipe }.uniq!

    @recipes = RecipePolicy::Scope.new(current_user, recipe_list).resolve#.order(:name)

    authorize @recipes.first

    render 'recipes/index'

    # if @recipe.save
    #   redirect_to @recipe
    # else
    #   flash[:alert] = @recipe.errors.full_messages
    #   render :new
    # end
  end
end
