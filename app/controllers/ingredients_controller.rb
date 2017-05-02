class IngredientsController < ApplicationController
  def index
    @ingredients = policy_scope(Ingredient).order(:name)
  end

  def show
    @ingredient = Ingredient.find_by(id: params[:id])
    authorize @ingredient
  end
end
