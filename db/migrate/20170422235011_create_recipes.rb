class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.string :photo_path
      t.text   :description
      t.time   :total_time
      t.timestamps
    end
    add_foreign_key :recipes, :users
  end
end
