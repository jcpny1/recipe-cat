class RecipesController < ApplicationController
  def index
    @recipes = Recipe.order(:name)
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
  end
end
