class CreateUnitConversions < ActiveRecord::Migration[5.0]
  def change
    create_table :unit_conversions do |t|
      t.belongs_to :from_unit, :class_name => 'Unit'
      t.belongs_to :to_unit,   :class_name => 'Unit'
      t.float      :multiplier
      t.timestamps
    end
    add_foreign_key :unit_conversions, :units, column: :from_unit_id
    add_foreign_key :unit_conversions, :units, column: :to_unit_id
  end
end
