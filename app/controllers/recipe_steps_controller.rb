class RecipeStepsController < ApplicationController
  before_action :get_recipe

  def new
    @recipe_step = @recipe.recipe_steps.new
    authorize @recipe_step
  end

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

  def edit
    @recipe_step = @recipe.recipe_steps.find(params[:id])
    authorize @recipe_step
  end

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

  def destroy
    recipe_step = @recipe.recipe_steps.find(params[:id])
    authorize recipe_step
    recipe_step.destroy
    redirect_to request.referer
  end

private

  def get_recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_name = @recipe.name
  end

  def recipe_step_params
    params.require(:recipe_step).permit(:step_number, :description)
  end
end
