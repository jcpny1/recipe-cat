class UserRecipeReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action  :verify_policy_scoped

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @recipe_reviews = UserRecipeReviewPolicy::Scope.new(current_user, UserRecipeReview).user_only(@user).order(:created_at)
      @user_reviews = true
    else
      @recipe_reviews = UserRecipeReview.where(recipe_id: params[:recipe_id]).order(:created_at)
    end
  end
end
