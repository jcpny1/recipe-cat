class UserIngredient < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient
  belongs_to :unit
end
