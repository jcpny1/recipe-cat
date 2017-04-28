class RecipeIngredientsController < ApplicationController
  skip_after_action :verify_authorized

  def create
    session[:ingredient_filter] = params[:recipe_ingredient][:ingredient]
    redirect_to recipes_path
  end
end
