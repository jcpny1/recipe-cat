class RecipePolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope
    end

    def user_only
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def index
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    !!user
  end

  def edit?
    update?
  end

  def update?
    !!user && (user.admin? || user.id == record.user_id)
  end

  def destroy?
    update?
  end
end
