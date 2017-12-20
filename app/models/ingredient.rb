# an ingredient that can be used in a recipe.
class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence:   true
  validates :name, uniqueness: true

  # do not allow photo_path to be null.
  after_initialize do |ingredient|
    ingredient.photo_path ||= 'ingredients/placeholder.jpg'
  end

  # returns an ordered list of ingredients to use in a select list.
  def self.pick_list
    Ingredient.order(:name).collect { |i| [i.name, i.id] }
  end
end
