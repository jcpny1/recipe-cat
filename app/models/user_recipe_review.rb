class UserRecipeReview < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def self.filter_array_by_user(recipe_reviews, user_id)
    recipe_reviews.find_all { |recipe_review| recipe_review.user_id == user_id.to_i }
  end

  def self.sort_by_recipe_and_time(recipe_reviews)
    recipe_reviews.sort { |recipe_review_1,recipe_review_2|
      if recipe_review_1.recipe.name != recipe_review_2.recipe.name
        recipe_review_1.recipe.name <=> recipe_review_2.recipe.name
      else
        recipe_review_1.created_at <=> recipe_review_2.created_at
      end
    }
  end
end
