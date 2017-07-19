# Rails contoller for RecipeIngredient model.
class RecipeIngredientsController < ApplicationController
    before_action :get_recipe, except: [:index]

  def index
    @recipe_ingredients = RecipeIngredient.sort_by_ingredient_name(policy_scope(RecipeIngredient.where("recipe_id = ?", params[:recipe_id])).order(:ingredient_id))
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @recipe_ingredients, include: ['ingredient', 'unit']}
    end
  end

  # prepare to create a new recipe ingredient.
  def new
    @recipe_ingredient = @recipe.recipe_ingredients.new
    authorize @recipe_ingredient
  end

  # add a new ingredient to a recipe.
  def create
    @recipe_ingredient = @recipe.recipe_ingredients.create_recipe_ingredient(recipe_ingredient_params)
    authorize @recipe_ingredient
    if @recipe_ingredient.save
      redirect_to @recipe
    else
      flash.now[:alert] = @recipe_ingredient.errors.full_messages
      render :new
    end
  end

  # edit a recipe ingredient record.
  def edit
    @recipe_ingredient = @recipe.recipe_ingredients.find(params[:id])
    authorize @recipe_ingredient
  end

  # commit recipe ingredient edits to the database.
  def update
    @recipe_ingredient = @recipe.recipe_ingredients.find(params[:id])
    @recipe_ingredient.update_recipe_ingredient(recipe_ingredient_params)
    authorize @recipe_ingredient
    if @recipe_ingredient.save
      redirect_to @recipe
    else
      flash.now[:alert] = @recipe_ingredient.errors.full_messages
      render :edit
    end
  end

  # remove an ingredient from a recipe.
  def destroy
    recipe_ingredient = @recipe.recipe_ingredients.find(params[:id])
    authorize recipe_ingredient
    recipe_ingredient.destroy
    redirect_to request.referer
  end

private

  # load the recipe identified in the route.
  def get_recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_name = @recipe.name
  end

  # filter params for allowed elements only.
  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:ingredient_id, :new_ingredient, :quantity, :unit_id)
  end
end
