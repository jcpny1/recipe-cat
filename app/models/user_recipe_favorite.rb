class UserRecipeFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def favorite
    user.user_recipe_favorites.exists?(recipe_id: self.recipe_id)
  end
end
