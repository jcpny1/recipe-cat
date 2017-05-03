class RecipeStep < ApplicationRecord
  belongs_to :recipe
  validates :step_number, uniqueness: { scope: :recipe, message: "must be unique for this recipe" }
end
