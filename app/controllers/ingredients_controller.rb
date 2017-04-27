class IngredientsController < ApplicationController
  # skip_before_action :authenticate_user!,   only: [:index, :show]
  # skip_after_action  :verify_policy_scoped, only: [:index, :show]

  def index
    @ingredients = policy_scope(Ingredient).order(:name)
  end

  def show
    @ingredient = Ingredient.find_by(id: params[:id])
    authorize @ingredient
  end
end
