class CreateUserRecipeFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :user_recipe_favorites do |t|
      t.belongs_to :user
      t.belongs_to :recipe
      t.timestamps
    end
    add_foreign_key :user_recipe_favorites, :users
    add_foreign_key :user_recipe_favorites, :recipes
  end
end
