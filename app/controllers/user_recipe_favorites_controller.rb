class UserRecipeFavoritesController < ApplicationController
  # display recipes that are the user's favorites, ordered by recipe name.
  def index
    user = User.find_by(id: params[:user_id])
    user_recipe_favorites = policy_scope(UserRecipeFavorite).where(user_id: user.id)
    @recipes = UserRecipeFavorite.recipes(user_recipe_favorites)
    @recipes = Recipe.filter_array_by_ingredient(@recipes, session[:ingredient_filter]) if session[:ingredient_filter].present?  # filter by ingredient, if necessary.
    @user_name = user.email
  end

  # update the user's recipe favorite indicator.
  def update
    user = User.find_by(id: params[:user_id])
    recipe_id = params[:id]
    user_recipe_favorite = UserRecipeFavorite.new(user_id: user.id, recipe_id: recipe_id)
    authorize user_recipe_favorite
    if params[:favorite] == 'false' # if favorite is not checked
      user.user_recipe_favorites.where(recipe_id: recipe_id).first.destroy # remove recipe from favorites.
    elsif !user.user_recipe_favorites.exists?(recipe_id: recipe_id) # if favorite is checked but recipe doesn't exist in favaorites yet
      user.user_recipe_favorites.create(user_id: user.id, recipe_id: recipe_id) # add to recipe favorites
    end
    render json: {}
  end
end
