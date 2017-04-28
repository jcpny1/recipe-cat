class UserRecipeFavoritePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end

    def user_only(for_user)
      if user.admin?
        scope.where(user_id: for_user.id)
      else
        raise Pundit::NotAuthorizedError unless user == for_user
        scope.where(user_id: user.id)
      end
    end
  end

  def update?
    user.admin? || record.try(:user) == user
  end

end
