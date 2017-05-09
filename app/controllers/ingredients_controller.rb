class IngredientsController < ApplicationController
  skip_after_action :verify_authorized,    only: :updated_after
  after_action      :verify_policy_scoped, only: :updated_after

  def updated_after   # list ingredients created or updated after the specified date.
    update_selector {
      @ingredients = policy_scope(Ingredient.updated_after(@date)).order(:name) }
    render :index
  end

  def index
    @ingredients = policy_scope(Ingredient).order(:name)
  end

  def show
    @ingredient = Ingredient.find_by(id: params[:id])
    authorize @ingredient
  end
end
