class RecipeStep < ApplicationRecord
  belongs_to :recipe
  validates :step_number, uniqueness: { scope: :recipe, message: "must be unique for this recipe" }

  def self.renumber(recipe_steps)
    step_counter = 1
    recipe_steps.each { |recipe_step|
      recipe_step.update(step_number: step_counter) if recipe_step != step_counter
      step_counter += 1
    }
  end
end
