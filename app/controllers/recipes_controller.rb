class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action  :verify_policy_scoped, only: :index  # seems like verify doesn't recognize a custom scope function.

  def index
    if params[:user_id]
      @recipes = RecipePolicy::Scope.new(current_user, Recipe).user_only
#      @recipes = Recipe.joins(:user).where(user_id: params[:user_id]).order(:name)
      @my_recipes = true
    else
      @recipes = policy_scope(Recipe).order(:name)
#      @recipes = Recipe.order(:name)
    end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    authorize @recipe
  end

end
