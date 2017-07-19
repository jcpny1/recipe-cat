class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :photo_path, :description
end
