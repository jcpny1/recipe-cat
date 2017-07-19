class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :unit_id
  has_one :ingredient
  has_one :unit
end
