class UserRecipeReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action  :verify_policy_scoped

  def index # render a list of @recipe_reviews ordered by recipe name/created_at.
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      reviews = UserRecipeReview.where(user_id: params[:user_id])
      @user_reviews = true
    else
      reviews = UserRecipeReview.where(recipe_id: params[:recipe_id]).order(:created_at)
    end

    @recipe_reviews = reviews.sort { |recipe_review_1,recipe_review_2|
      if recipe_review_1.recipe.name != recipe_review_2.recipe.name
        recipe_review_1.recipe.name <=> recipe_review_2.recipe.name
      else
        recipe_review_1.created_at <=> recipe_review_2.created_at
      end
    }
  end
end
