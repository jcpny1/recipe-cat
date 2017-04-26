class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :user_recipe_reviews
  has_many :user_recipe_favorites
  has_many :recipe_steps

  validates :name, presence:   true
  validates :name, uniqueness: true

  def average_stars
    sum = user_recipe_reviews.sum { |urr| urr.stars }
    sum.to_f / number_of_reviews if number_of_reviews != 0
  end

  def number_of_reviews
    user_recipe_reviews.size
  end
end
