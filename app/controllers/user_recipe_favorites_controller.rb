class UserRecipeFavoritesController < ApplicationController
  def index
    recipe_favorites = UserRecipeFavorite.joins(:user).where(user_id: current_user.id)
    @recipes = recipe_favorites.collect { |rf| rf.recipe }.sort! { |recipe1,recipe2|
      recipe1.name <=> recipe2.name
    }
    @my_favorites = true
    render 'recipes/index'
  end
end
