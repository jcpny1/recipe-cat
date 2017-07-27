class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :photo_path, :description, :total_time
  has_one :author
  has_many :recipe_ingredients
  has_many :recipe_steps
  has_many :recipe_reviews
  has_many :user_recipe_favorites
end
