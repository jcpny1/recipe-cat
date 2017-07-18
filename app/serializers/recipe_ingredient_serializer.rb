class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :ingredient_id, :quantity, :unit_id
end
