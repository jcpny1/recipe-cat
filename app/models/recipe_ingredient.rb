class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :unit, optional: true
  validates :quantity, numericality: { greater_than: 0 }
  validate :check_ingredient

  def check_ingredient
    if self.ingredient.present? && new_ingredient.present?
      errors.add(:ingredient, 'and New Ingredient cannot both be specified')
    end
  end

  def ingredient_name
    self.ingredient.name
  end

  def new_ingredient
    @new_ingredient
  end

  def new_ingredient=(value)
    @new_ingredient = value
  end
end
