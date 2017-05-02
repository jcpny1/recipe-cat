class UserRecipeReviewsController < ApplicationController

  def index
    @recipe_reviews = policy_scope(UserRecipeReview)

    if params[:user_id].present?
      @recipe_reviews = UserRecipeReview.filter_array_by_user(@recipe_reviews, params[:user_id])
      user = User.find_by(id: params[:user_id])
      @user_reviews = true
    else
      user = current_user
    end

    @recipe_reviews = UserRecipeReview.sort_by_recipe_and_time(@recipe_reviews)
    @user_email = user.email if user
  end
end
