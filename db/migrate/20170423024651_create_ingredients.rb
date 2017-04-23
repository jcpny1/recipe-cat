class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.string     :name
      t.float      :quantity
      t.integer    :unit_id
      t.timestamps
    end
    add_foreign_key :ingredients, :units
  end
end
