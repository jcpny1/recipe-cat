class RecipeIngredientsController < ApplicationController
    before_action :get_recipe, except: [:filter]

  def filter   # only setting ingredient_filter value here.
    skip_authorization
    session[:ingredient_filter] = params[:recipe_ingredient][:ingredient]
    redirect_to recipes_path
  end

  def new
    @recipe_ingredient = @recipe.recipe_ingredients.new
    authorize @recipe_ingredient
  end

  def create
    @recipe_ingredient = @recipe.recipe_ingredients.new(ingredient_id: params[:recipe_ingredient][:ingredient], quantity: params[:recipe_ingredient][:quantity], unit_id: params[:recipe_ingredient][:unit])
    authorize @recipe_ingredient
    if @recipe.save
      redirect_to @recipe
    else
      flash[:alert] = @recipe_ingredient.errors.full_messages
      render :new
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

end
