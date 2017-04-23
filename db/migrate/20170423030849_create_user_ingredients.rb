class CreateUserIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :user_ingredients do |t|
      t.belongs_to :user
      t.belongs_to :ingredient
      t.float      :quantity
      t.integer    :unit_id
      t.timestamps
    end
    add_foreign_key :user_ingredients, :user
    add_foreign_key :user_ingredients, :ingredient
    add_foreign_key :user_ingredients, :units
  end
end
