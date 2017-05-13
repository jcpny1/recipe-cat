# Rails controller for RecipeStep model.
class RecipeStepsController < ApplicationController
  before_action :get_recipe

  # prepare to create a new recipe step.
  def new
    @recipe_step = @recipe.recipe_steps.new
    authorize @recipe_step
  end

  # add a new step tp a recipe.
  def create
    @recipe_step = @recipe.recipe_steps.new(recipe_step_params)
    authorize @recipe_step
    if @recipe_step.save
      redirect_to @recipe
    else
      flash.now[:alert] = @recipe_step.errors.full_messages
      render :new
    end
  end

  # edit a recipe step record.
  def edit
    @recipe_step = @recipe.recipe_steps.find(params[:id])
    authorize @recipe_step
  end

  # commit recipe step edits to the database.
  def update
    @recipe_step = @recipe.recipe_steps.find(params[:id])
    authorize @recipe_step
    if @recipe_step.update(recipe_step_params)
      redirect_to @recipe
    else
      flash.now[:alert] = @recipe_step.errors.full_messages
      render 'edit'
    end
  end

  # remove a recipe step from a recipe and delete it.
  def destroy
    recipe_step = @recipe.recipe_steps.find(params[:id])
    authorize recipe_step
    recipe_step.destroy
    redirect_to request.referer
  end

private

# load the recipe identified in the route.
  def get_recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_name = @recipe.name
  end

  # filter params for allowed elements only.
  def recipe_step_params
    params.require(:recipe_step).permit(:step_number, :description)
  end
end
