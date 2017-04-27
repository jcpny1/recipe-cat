class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.belongs_to :user, index: true
      t.string :name,        null: false
      t.string :photo_path,  null: false
      t.text   :description, null: false
      t.time   :total_time,  null: false
      t.timestamps
    end
    add_foreign_key :recipes, :users
  end
end
