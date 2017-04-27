class UserRecipeReviewsController < ApplicationController
  skip_after_action  :verify_policy_scoped, only: :index  # seems like verify doesn't recognize a custom scope function.

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @recipe_reviews = UserRecipeReviewPolicy::Scope.new(current_user, UserRecipeReview).user_only(@user).order(:created_at)
      @user_reviews = true
    else
      # @recipe_reviews = policy_scope(UserRecipeReview).order(:created_at)
      recipe = Recipe.find_by(id: params[:recipe_id])
      @recipe_reviews = UserRecipeReviewPolicy::Scope.new(current_user, UserRecipeReview).recipe_only(recipe).order(:created_at)
    end
  end
end
