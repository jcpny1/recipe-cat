class UserRecipeFavoritesController < ApplicationController
  def index
    recipe_favorites = policy_scope(UserRecipeFavorite)
    @recipes = recipe_favorites.collect { |rf| rf.recipe }.sort! { |recipe1,recipe2|
      recipe1.name <=> recipe2.name
    }
    @user_favorites = true
    render 'recipes/index'
  end
end
