class CreateRecipeIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_ingredients do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient
      t.float      :quantity
      t.belongs_to :unit
      t.timestamps
    end
    add_foreign_key :recipe_ingredients, :recipes
    add_foreign_key :recipe_ingredients, :ingredients
    add_foreign_key :recipe_ingredients, :units
  end
end
