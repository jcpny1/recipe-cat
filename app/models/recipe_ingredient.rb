# an ingredient that is used in a particular recipe.
class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :unit, optional: true
  validates :quantity, numericality: { greater_than: 0 }
  validate :check_ingredient

  @new_ingredient  # holds user-inputted ingredient name (for use in creating a new Ingredient, if necessary).

  # new_ingredient getter.
  def new_ingredient
    @new_ingredient
  end

  # new_ingredient setter.
  def new_ingredient=(value)
    @new_ingredient = value
  end

  # returns the user who created this recipe ingredient.
  def author
    self.recipe.author
  end

  # validates that a pre-existing Ingredient and a new Ingredient are not both specified.
  def check_ingredient
    if self.ingredient.present? && self.new_ingredient.present?
      errors.add(:ingredient, 'and New Ingredient cannot both be specified')
    end
  end

  # creates a new Ingredient and clears out new_ingredient value.
  def create_new_ingredient
    if self.new_ingredient.present?
      self.ingredient = Ingredient.create_ingredient(self.new_ingredient)
      self.new_ingredient = ''  # clear out to pass validation. ingredient and new_ingredient can't both be present.
    end
  end

  # adds Ingredient to Recipe.
  # returns a new recipe_ingredient record (or nil).
  def self.create_recipe_ingredient(recipe_ingredients_params)
    if recipe_ingredients_params[:ingredient_id].present? || recipe_ingredients_params[:new_ingredient].present?
      recipe_ingredient = RecipeIngredient.new(recipe_ingredients_params)
      recipe_ingredient.create_new_ingredient
    end
    recipe_ingredient
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

  # updates existing recipe_ingredient with new values.
  def update_recipe_ingredient(recipe_ingredient_params)
    self.assign_attributes(recipe_ingredient_params)
    self.create_new_ingredient if self.new_ingredient.present?
  end
end
