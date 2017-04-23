class CreateUnitConversions < ActiveRecord::Migration[5.0]
  def change
    create_table :unit_conversions do |t|
      t.integer :from_unit_id
      t.integer :to_unit_id
      t.timestamps
    end
    add_foreign_key :unit_conversions, :units, column: :from_unit_id
    add_foreign_key :unit_conversions, :units, column: :to_unit_id
  end
end
