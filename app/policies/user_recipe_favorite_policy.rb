class UserRecipeFavoritePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def update?
# This logic is a little different than the other policies.
# Just check that the user_id of this favorite record equals the user_id of the user making the change.
# Do not consider the author of the record.
    user && (user.admin? || record.user_id == user.id)
  end
end
