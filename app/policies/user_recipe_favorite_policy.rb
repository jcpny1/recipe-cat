class UserRecipeFavoritePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
#      if user.admin?
      if false
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
