class CreateUserIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :user_ingredients do |t|
      t.belongs_to :user
      t.belongs_to :ingredient
      t.float      :quantity
      t.belongs_to :unit
      t.timestamps
    end
    add_foreign_key :user_ingredients, :users
    add_foreign_key :user_ingredients, :ingredients
    add_foreign_key :user_ingredients, :units
  end
end
