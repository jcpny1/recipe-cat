class UserRecipeReviewsController < ApplicationController
  def index
    if params[:user_id]
      @user_recipe_reviews = UserRecipeReview.joins(:user).where(user_id: params[:user_id]).order(:created_at)
    else
      @user_recipe_reviews = UserRecipeReview.all.order(:created_at)
    end
  end
end
