class CreateUserRecipeReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :user_recipe_reviews do |t|
      t.belongs_to :recipe
      t.belongs_to :user
      t.integer    :stars
      t.string     :title
      t.text       :comments
      t.timestamps
    end
    add_foreign_key :user_recipe_reviews, :users
    add_foreign_key :user_recipe_reviews, :recipes
  end
end
