class IngredientsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @ingredients = Ingredient.order(:name)
  end

  def show
    @ingredient = Ingredient.find_by(id: params[:id])
  end
end
