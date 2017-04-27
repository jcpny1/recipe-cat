class UserRecipeReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action  :verify_policy_scoped

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
# would rather sort on recipe name, not recipe id
      @recipe_reviews = UserRecipeReview.where(user_id: params[:user_id]).order(:recipe_id, :created_at)
      @user_reviews = true
    else
      @recipe_reviews = UserRecipeReview.where(recipe_id: params[:recipe_id]).order(:created_at)
    end
  end
end
