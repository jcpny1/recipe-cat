class CreateRecipeReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_reviews do |t|
      t.belongs_to :recipe
      t.belongs_to :user
      t.integer    :stars
      t.string     :title
      t.text       :comments
      t.timestamps
    end
    add_foreign_key :recipe_reviews, :recipes
    add_foreign_key :recipe_reviews, :users
  end
end
