class RecipeStep < ApplicationRecord
  belongs_to :recipe
  validates :step_number, uniqueness: { scope: :recipe, message: "must be unique for this recipe" }

  def recipe_user
    self.recipe.user
  end

  def self.renumber(recipe_steps)
    step_counter = 1
    recipe_steps.sort { |rs1, rs2| rs1.step_number <=> rs2.step_number }.each { |recipe_step|
      recipe_step.update(step_number: step_counter) if recipe_step != step_counter
      step_counter += 1
    }
  end
end
