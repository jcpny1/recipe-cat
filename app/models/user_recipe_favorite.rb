class UserRecipeFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def favorite
    user.user_recipe_favorites.exists?(recipe_id: self.recipe_id)
  end

  def self.filter_array_by_user(recipe_favorites, user_id)
    recipe_favorites.find_all { |recipe_favorite| recipe_favorite.user_id == user_id.to_i }
  end

  def self.get_recipes_from_favorites(recipe_favorites)
    recipe_favorites.collect { |favorite| favorite.recipe }
  end
end
