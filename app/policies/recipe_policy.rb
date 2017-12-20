class RecipePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
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
    user && (user.admin? || record.author == user || record.author.nil?)
  end

  def destroy?
    update?
  end
end
