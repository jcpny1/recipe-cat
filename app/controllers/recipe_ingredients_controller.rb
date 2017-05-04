class RecipeIngredientsController < ApplicationController
    before_action :get_recipe

  def new
    @recipe_ingredient = @recipe.recipe_ingredients.new
    authorize @recipe_ingredient
  end

  def create
    @recipe_ingredient = @recipe.recipe_ingredients.new(recipe_ingredient_params)
    set_new_ingredient
    authorize @recipe_ingredient

    if @recipe_ingredient.save
      redirect_to @recipe
    else
      flash.now[:alert] = @recipe_ingredient.errors.full_messages
      render :new
    end
  end

  def edit
    @recipe_ingredient = @recipe.recipe_ingredients.where(id: params[:id]).first
    authorize @recipe_ingredient
  end

  def update
    @recipe_ingredient = @recipe.recipe_ingredients.where(id: params[:id]).first
    @recipe_ingredient.assign_attributes(recipe_ingredient_params)
    set_new_ingredient
    authorize @recipe_ingredient

    if @recipe_ingredient.save
      redirect_to @recipe
    else
      flash.now[:alert] = @recipe_ingredient.errors.full_messages
      render :edit
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
    params.require(:recipe_ingredient).permit(:ingredient_id, :new_ingredient, :quantity, :unit_id)
  end

  def set_new_ingredient
    if @recipe_ingredient.new_ingredient.present? && @recipe_ingredient.ingredient.nil?
      @recipe_ingredient.ingredient = Ingredient.create_ingredient(@recipe_ingredient.new_ingredient)
      @recipe_ingredient.new_ingredient = ''  # clear out to pass validation.
    end
  end
end
