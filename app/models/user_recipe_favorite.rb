class UserRecipeFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def favorite
    if self.user_id.nil?
      false
    else
      user.user_recipe_favorites.exists?(recipe_id: self.recipe_id)
    end
  end

  def favorite=(value)
  end
end
