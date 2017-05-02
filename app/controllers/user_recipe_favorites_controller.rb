class UserRecipeFavoritesController < ApplicationController

  def index # render a list of @recipes that are the user's favorites ordered by recipe name.
    recipe_favorites = policy_scope(UserRecipeFavorite)

    if params[:user_id].present?
      recipe_favorites = UserRecipeFavorite.filter_array_by_user(recipe_favorites, params[:user_id])
      user = User.find_by(id: params[:user_id])
    else
      user = current_user
    end

    @recipes = UserRecipeFavorite.get_recipes_from_favorites(recipe_favorites).sort! { |recipe1,recipe2| recipe1.name <=> recipe2.name }
    @user_email = user.email if user
    render 'recipes/index'
  end

  def update
    user = User.find_by(id: params[:user_id])
    recipe_id = params[:id]
    user_recipe_favorite = UserRecipeFavorite.new(user_id: user.id, recipe_id: recipe_id)
    authorize user_recipe_favorite

    favorite_flag = params[:user_recipe_favorite][:favorite] # "0" or "1"

    if favorite_flag == "0" # remove favorite
      user_favorite = user.user_recipe_favorites.where(recipe_id: recipe_id).first.destroy
    elsif !user.user_recipe_favorites.exists?(recipe_id: recipe_id) # add favorite
      user.user_recipe_favorites.create(user_id: user.id, recipe_id: recipe_id)
    end
    redirect_to request.referer
  end
end
