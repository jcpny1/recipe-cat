class UserRecipeFavoritesController < ApplicationController
  def index
    @user_recipe_favorites = UserRecipeFavorite.joins(:user).where(user_id: current_user.id)
  end
end
