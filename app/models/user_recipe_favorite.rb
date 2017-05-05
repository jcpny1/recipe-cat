class UserRecipeFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def favorite
    user.user_recipe_favorites.exists?(recipe_id: self.recipe_id)
  end

  # get recipes from user_recipe_favorites.
  def self.recipes(user_recipe_favorites)
    user_recipe_favorites.collect { |user_recipe_favorite| user_recipe_favorite.recipe }.sort! { |recipe1,recipe2| recipe1.name <=> recipe2.name }
  end
end
