class RecipePolicy < ApplicationPolicy
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

  def show?
    true
  end

  def new?
    !!user
  end

  def create?
    !!user
  end

  def update?
    user.admin? || user.moderator? || record.try(:user) == user
  end
end
