class RecipeReviewSerializer < ActiveModel::Serializer
  attributes :id, :recipe_id, :user_id, :stars, :title, :comments, :created_at
  has_one :author
end
