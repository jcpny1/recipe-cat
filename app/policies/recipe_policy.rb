class RecipePolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope
    end
  end

  def renumber_steps?
    update?
  end

  def index?
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
    !!user && (user.admin? || record.user_id == user.id)
  end

  def destroy?
    update?
  end
end
