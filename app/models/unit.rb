class Unit < ApplicationRecord
  has_many :unit_conversions
  has_many :from_units, class_name: "UnitConversion", foreign_key: "from_unit_id"
  has_many :to_units,   class_name: "UnitConversion", foreign_key: "to_unit_id"
  validates :name, presence:   true
  validates :name, uniqueness: true
end
