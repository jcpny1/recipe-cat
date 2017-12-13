# rails model base class.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :updated_after, ->(date) { where('updated_at > ?', date) }
end
