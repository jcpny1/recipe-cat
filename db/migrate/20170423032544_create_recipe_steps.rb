class CreateRecipeSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_steps do |t|
      t.belongs_to :recipe
      t.integer    :step_number
      t.text       :description
      t.timestamps
    end
    add_foreign_key :recipe_steps, :recipes
  end
end
