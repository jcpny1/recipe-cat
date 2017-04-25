class UserRecipeReviewsController < ApplicationController
  def index
    if params[:id]
      @user_recipe_reviews = UserRecipeReview.joins(:user).where(user_id: params[:id])
    else
      @user_recipe_reviews = UserRecipeReview.all
    end
  end
end
