class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:user_id]
      @recipes = Recipe.joins(:user).where(user_id: params[:user_id]).order(:name)
      @my_recipes = true
    else
      @recipes = Recipe.order(:name)
      @my_recipes = false
    end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
  end

end
