# contains the units of measure available for ingredients.
class Unit < ApplicationRecord
  has_many :unit_conversions
  has_many :from_units, class_name: 'UnitConversion', foreign_key: 'from_unit_id'
  has_many :to_units,   class_name: 'UnitConversion', foreign_key: 'to_unit_id'
  has_many :recipe_ingredients
  validates :name, uniqueness: true

  # returns an ordered list of units to use in a select list.
  def self.pick_list
    Unit.order(:name).collect { |u| [u.name, u.id] }
  end
end
