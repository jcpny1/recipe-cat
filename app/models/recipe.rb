class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients,    dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_reviews,   dependent: :destroy
  has_many :user_recipe_favorites, dependent: :destroy
  has_many :recipe_steps,          dependent: :destroy

  validates :name, presence:   true
  validates :name, uniqueness: true

  def average_stars
    sum = recipe_reviews.sum { |urr| urr.stars }
    sum.to_f / number_of_reviews if number_of_reviews != 0
  end

  def self.filter_array_by_ingredient(recipes, ingredient_id)
    recipes.find_all { |recipe|
      recipe.recipe_ingredients.find_by(ingredient_id: ingredient_id)
    }
  end

  def self.filter_array_by_user(recipes, user_id)
    recipes.find_all { |recipe| recipe.user_id == user_id.to_i }
  end

  def number_of_reviews
    recipe_reviews.size
  end
end
