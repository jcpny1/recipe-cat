class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :photo_path, :description, :total_time, :created_at, :updated_at
  belongs_to :author
  has_many   :recipe_reviews
  has_many   :recipe_steps
  has_many   :user_recipe_favorites
end
