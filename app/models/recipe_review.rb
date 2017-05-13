# A user's review of a particular recipe.
class RecipeReview < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  validates :stars,    presence:   true
  validates :stars,    numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :title,    presence:   true
  validates :comments, presence:   true

  # the name of the recipe of this review.
  def recipe_name
    self.recipe.name
  end

  # returns recipe review list sorted by recipe name and review creation time within recipe name.
  def self.sort_by_recipe_and_time(recipe_reviews)
    recipe_reviews.sort { |recipe_review_1,recipe_review_2|
      if recipe_review_1.recipe_name != recipe_review_2.recipe_name
        recipe_review_1.recipe_name <=> recipe_review_2.recipe_name
      else
        recipe_review_1.created_at <=> recipe_review_2.created_at
      end
    }
  end

  # returns the user who created this recipe review.
  def user_name
    self.user.email
  end
end
