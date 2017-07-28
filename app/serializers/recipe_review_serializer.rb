class RecipeReviewSerializer < ActiveModel::Serializer
  attributes :id, :recipe_id, :user_id, :stars, :title, :comments
end
