class UserRecipeReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:user_id]
      return head :forbidden if params[:user_id].to_i != current_user.id
      @user_recipe_reviews = UserRecipeReview.joins(:user).where(user_id: params[:user_id]).order(:created_at)
      @my_reviews = true
    elsif params[:recipe_id]
      @user_recipe_reviews = UserRecipeReview.joins(:recipe).where(recipe_id: params[:recipe_id]).order(:created_at)
    else
      @user_recipe_reviews = UserRecipeReview.all.order(:created_at)
    end
  end
end
