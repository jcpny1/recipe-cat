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
    !!user && (user.admin? || user.id == record.user_id)
  end

end
