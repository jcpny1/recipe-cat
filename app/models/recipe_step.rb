# an instruction that is used in a particular recipe.
class RecipeStep < ApplicationRecord
  belongs_to :recipe
  validates :step_number, uniqueness: { scope: :recipe, message: "must be unique for this recipe" }

  # returns the user who created this recipe step.
  def author
    self.recipe.author
  end

  # renumbers the recipe steps in sequential order.
  def self.renumber(recipe_steps)
    step_counter = 1
    recipe_steps.sort { |rs1, rs2| rs1.step_number <=> rs2.step_number }.each { |recipe_step|
      recipe_step.update(step_number: step_counter) if recipe_step != step_counter
      step_counter += 1
    }
  end
end
