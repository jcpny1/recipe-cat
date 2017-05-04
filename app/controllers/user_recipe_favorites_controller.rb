class UserRecipeFavoritesController < ApplicationController

  def index # render a list of @recipes that are the user's favorites ordered by recipe name.
    user = User.find_by(id: params[:user_id])
    recipe_favorites = policy_scope(UserRecipeFavorite).where(user_id: user.id)
    @user_email = user.email
    @recipes = recipe_favorites.collect { |favorite| favorite.recipe }.sort! { |recipe1,recipe2| recipe1.name <=> recipe2.name }
  end

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
