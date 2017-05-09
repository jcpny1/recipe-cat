class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence:   true
  validates :name, uniqueness: true

  after_initialize do |ingredient|
    ingredient.photo_path ||= 'ingredients/placeholder.jpg'
  end

  def self.create_ingredient(name)
    Ingredient.find_or_create_by(name: name.titleize)
  end

  def self.pick_list
    Ingredient.order(:name).collect { |i| [ i.name, i.id ] }
  end
end
