class UserRecipeReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end

    def user_only
#      if user.admin?
      if false
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
