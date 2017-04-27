class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.string :name,        null: false
      t.string :photo_path,  null: false
      t.text   :description
      t.timestamps
    end
  end
end
