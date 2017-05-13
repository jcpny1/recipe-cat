# a geographical location.
class Address < ApplicationRecord
  belongs_to :user, optional: true
end
