class CreateRecipeIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_ingredients do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient
      t.float      :quantity
      t.integer    :unit_id
      t.timestamps
    end
    add_foreign_key :recipe_ingredients, :recipe
    add_foreign_key :recipe_ingredients, :ingredient
    add_foreign_key :recipe_ingredients, :units
  end
end
