class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :unit

#  scope :ingredient_id, -> (ingredient_id) { where ingredient_id: ingredient_id }
end
