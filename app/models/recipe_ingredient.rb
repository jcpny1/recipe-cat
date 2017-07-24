# an ingredient that is used in a particular recipe.
class RecipeIngredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :recipe_ingredients
  belongs_to :ingredient, optional: true
  belongs_to :unit, optional: true
  validates :quantity, numericality: { greater_than: 0 }
  default_scope { joins(:ingredient).order('ingredients.name') }

  # returns the user who created this recipe ingredient.
  def author
    self.recipe.author
  end

  # returns the name of this recipe_ingredient's ingredient.
  def ingredient_name
    self.ingredient.name
  end

  # returns recipe ingredient list sorted by ingredient name.
  def self.sort_by_ingredient_name(recipe_ingredients)
    recipe_ingredients.sort { |recipe_ingredient_1,recipe_ingredient_2|
      recipe_ingredient_1.ingredient.name <=> recipe_ingredient_2.ingredient.name
    }
  end
end
