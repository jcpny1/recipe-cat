class UserRecipeFavoritesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  skip_after_action  :verify_policy_scoped

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      recipe_favorites = UserRecipeFavorite.where(user_id: params[:user_id])
      @user_favorites = true
    else
      recipe_favorites = policy_scope(UserRecipeReview).order
    end
    @recipes = recipe_favorites.collect { |rf| rf.recipe }.sort! { |recipe1,recipe2|
      recipe1.name <=> recipe2.name
    }
    render 'recipes/index'
  end

  def update
    user = User.find_by(id: params[:user_id])
    recipe_id = params[:id]
    user_recipe_favorite = UserRecipeFavorite.new(user_id: user.id, recipe_id: recipe_id)
    authorize user_recipe_favorite
    favorite = params[:user_recipe_favorite][:favorite]
    if favorite == "0" # remove favorite status
      user_favorite = user.user_recipe_favorites.where(recipe_id: recipe_id)
      user_favorite.first.destroy if user_favorite
    elsif !user.user_recipe_favorites.exists?(recipe_id: recipe_id) # add favorite status
      user.user_recipe_favorites.create(user_id: user.id, recipe_id: recipe_id)
    end
    redirect_to recipe_path(recipe_id)
  end
end
