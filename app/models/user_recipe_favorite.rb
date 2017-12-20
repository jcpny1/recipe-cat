# a recipe that a user has favorited.
class UserRecipeFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  # returns the user who created this recipe favorite.
  def author
    recipe.author
  end

  # returns a list of recipes from a user's recipe_favorites list.
  def self.recipes(user_recipe_favorites)
    user_recipe_favorites.collect(&:recipe).sort! { |recipe1, recipe2| recipe1.name <=> recipe2.name }
  end
end
