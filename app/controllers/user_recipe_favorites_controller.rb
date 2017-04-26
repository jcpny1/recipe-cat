class UserRecipeFavoritesController < ApplicationController
  def index
    return head :forbidden if params[:user_id].to_i != current_user.id
    recipe_favorites = UserRecipeFavorite.joins(:user).where(user_id: params[:user_id])
    @recipes = recipe_favorites.collect { |rf| rf.recipe }.sort! { |recipe1,recipe2|
      recipe1.name <=> recipe2.name
    }
    @my_favorites = true
    render 'recipes/index'
  end
end
