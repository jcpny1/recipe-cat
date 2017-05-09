class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients,    dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_reviews,        dependent: :destroy
  has_many :user_recipe_favorites, dependent: :destroy
  has_many :recipe_steps,          dependent: :destroy

  validates :name, presence:   true
  validates :name, uniqueness: true

  after_initialize do |recipe|
    recipe.photo_path ||= 'recipes/placeholder.png'
  end

  def average_stars
    sum = recipe_reviews.sum { |urr| urr.stars }
    number_of_reviews != 0 ? (sum.to_f / number_of_reviews).round : 0
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

  def recipe_user
    self.user
  end

  def user_name
    recipe_user.email
  end
end
