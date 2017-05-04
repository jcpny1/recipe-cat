class RecipeReviewsController < ApplicationController

  def index

    if params[:user_id].present?
      user = User.find_by(id: params[:user_id])
      @recipe_reviews = policy_scope(RecipeReview).where(user_id: user.id)
      @user_email = user.email
      @user_reviews = true
    elsif params[:recipe_id].present?
      @recipe_reviews = policy_scope(RecipeReview).where(recipe_id: params[:recipe_id])
    end

    @recipe_reviews = RecipeReview.sort_by_recipe_and_time(@recipe_reviews)
  end
end
