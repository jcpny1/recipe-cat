# Rails controller for RecipeStep model.
class RecipeStepsController < ApplicationController
  def index
    @recipe_steps = policy_scope(RecipeStep.where("recipe_id = ?", params[:recipe_id])).order(:step_number)
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @recipe_steps }
    end
  end
end
