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
    !!user && (user.admin? || record.user_id == user.id)
  end

end
