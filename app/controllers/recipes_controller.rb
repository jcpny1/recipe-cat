class RecipesController < ApplicationController
  def index
    if params[:user_id]
      @recipes = Recipe.joins(:user).where(user_id: params[:user_id]).order(:name)
    else
      @recipes = Recipe.order(:name)
    end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
  end
end
