# Rails controller for Ingredient model.
class IngredientsController < ApplicationController
  skip_after_action :verify_authorized,    only: :updated_after
  after_action      :verify_policy_scoped, only: :updated_after

  # display ingredients created or updated after the specified date.
  def updated_after
    update_selector { @ingredients = policy_scope(Ingredient.updated_after(@date)).order(:name) }
    render :index
  end

  # display all ingredients.
  def index
    @ingredients = policy_scope(Ingredient).order(:name)
  end

  # display a specific ingredient.
  def show
    @ingredient = Ingredient.find_by(id: params[:id])
    authorize @ingredient
  end
end
