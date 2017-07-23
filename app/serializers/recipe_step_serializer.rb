class RecipeStepSerializer < ActiveModel::Serializer
  attributes :id, :step_number, :description
end
