class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :user_recipe_reviews, dependent: :destroy
  has_many :user_recipe_favorites, dependent: :destroy
  has_many :recipe_steps, dependent: :destroy

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
