class UserRecipeReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action  :verify_policy_scoped, only: :index  # seems like verify doesn't recognize a custom scope function.

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @recipe_reviews = UserRecipeReviewPolicy::Scope.new(@user, UserRecipeReview).user_only.order!(:created_at)
      @user_reviews = true
    else
      @recipe_reviews = policy_scope(UserRecipeReview).order(:created_at)
    end
  end
end
