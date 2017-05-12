class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :unit, optional: true
  validates :quantity, numericality: { greater_than: 0 }
  validate :check_ingredient

  @new_ingredient  # holds user-inputted ingredient name (rather than a pre-defined Ingredient's id).

  def new_ingredient
    @new_ingredient
  end

  def new_ingredient=(value)
    @new_ingredient = value
  end

  def check_ingredient
    if self.ingredient.present? && self.new_ingredient.present?
      errors.add(:ingredient, 'and New Ingredient cannot both be specified')
    end
  end

  def create_new_ingredient
    if self.new_ingredient.present?
      self.ingredient = Ingredient.create_ingredient(self.new_ingredient)
      self.new_ingredient = ''  # clear out to pass validation. ingredient and new_ingredient can't both be present.
    end
  end

  def self.create_recipe_ingredient(recipe_ingredients_params)
    if recipe_ingredient_params[:ingredient_id].present? || recipe_ingredient_params[:new_ingredient].present?
      recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)
      recipe_ingredient.create_new_ingredient
    end
    recipe_ingredient
  end

  def ingredient_name
    self.ingredient.name
  end

  def recipe_user
    self.recipe.recipe_user
  end

  def update_recipe_ingredient(recipe_ingredient_params)
    self.assign_attributes(recipe_ingredient_params)
    self.create_new_ingredient if self.new_ingredient.present?
  end
end
