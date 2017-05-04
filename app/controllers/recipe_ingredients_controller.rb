class RecipeIngredientsController < ApplicationController
    before_action :get_recipe

  def new
    @recipe_ingredient = @recipe.recipe_ingredients.new
    authorize @recipe_ingredient
  end

  def create
    @recipe_ingredient = @recipe.recipe_ingredients.new(recipe_ingredient_params)
    authorize @recipe_ingredient
    if @recipe_ingredient.save
      redirect_to @recipe
    else
      flash[:alert] = @recipe_ingredient.errors.full_messages
      render :new
    end
  end

  def edit
    @recipe_ingredient = @recipe.recipe_ingredients.where(id: params[:id]).first
    authorize @recipe_ingredient
  end

  def update
    @recipe_ingredient = @recipe.recipe_ingredients.where(id: params[:id]).first
    authorize @recipe_ingredient
    if @recipe_ingredient.update(recipe_ingredient_params)
      redirect_to @recipe
    else
      flash[:alert] = @recipe_ingredient.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    recipe_ingredient = @recipe.recipe_ingredients.find(params[:id])
    authorize recipe_ingredient
    recipe_ingredient.destroy
    redirect_to request.referer
  end

private

  def get_recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_name = @recipe.name
  end

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:ingredient_id, :quantity, :unit_id)
  end
end
