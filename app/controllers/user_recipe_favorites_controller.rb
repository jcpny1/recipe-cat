class UserRecipeFavoritesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  skip_after_action  :verify_policy_scoped

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      recipe_favorites = UserRecipeFavorite.where(user_id: params[:user_id])
      @user_favorites = true
    else
      recipe_favorites = policy_scope(UserRecipeReview).order
    end
    @recipes = recipe_favorites.collect { |rf| rf.recipe }.sort! { |recipe1,recipe2|
      recipe1.name <=> recipe2.name
    }
    render 'recipes/index'
  end
end
