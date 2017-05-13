class UserRecipeFavoritesController < ApplicationController

  # display recipes that are the user's favorites, ordered by recipe name.
  def index
    user = User.find_by(id: params[:user_id])
    user_recipe_favorites = policy_scope(UserRecipeFavorite).where(user_id: user.id)
    @user_name = user.email
    @recipes = UserRecipeFavorite.recipes(user_recipe_favorites)
  end

  # update the user's recipe favorite indicator.
  def update
    user = User.find_by(id: params[:user_id])
    recipe_id = params[:id]
    user_recipe_favorite = UserRecipeFavorite.new(user_id: user.id, recipe_id: recipe_id)
    authorize user_recipe_favorite

    favorite_flag = params[:user_recipe_favorite][:favorite] # "0" or "1"

    if favorite_flag == "0" # if favorite is off
      user.user_recipe_favorites.where(recipe_id: recipe_id).first.destroy # remove favorite
    elsif !user.user_recipe_favorites.exists?(recipe_id: recipe_id) # favorite is on
      user.user_recipe_favorites.create(user_id: user.id, recipe_id: recipe_id) # add favorite
    end
    redirect_to request.referer
  end
end
