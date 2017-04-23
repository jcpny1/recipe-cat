class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :user_recipe_reviews
  has_many :user_recipe_favorites
  has_many :recipe_steps
end
