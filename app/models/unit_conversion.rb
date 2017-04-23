class UnitConversion < ApplicationRecord
  belongs_to :from_unit, class_name: "Unit", foreign_key: "from_unit_id"
  belongs_to :to_unit,   class_name: "Unit", foreign_key: "to_unit_id"
end
