# an instruction that is used in a particular recipe.
class RecipeStep < ApplicationRecord
  belongs_to :recipe, inverse_of: :recipe_steps
  validates :step_number, numericality: { greater_than: 0 }
  default_scope { order(:step_number) }

  # returns the user who created this recipe step.
  def author
    self.recipe.author
  end

  # adds Step to Recipe.
  # returns a new recipe_step record (or undefined).
  def self.create_recipe_step(recipe_steps_params)
    if recipe_steps_params[:step_number].present?
      recipe_step = RecipeStep.new(recipe_steps_params)
    end
    recipe_step
  end
end
