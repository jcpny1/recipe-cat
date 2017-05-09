class RecipeReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
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
    !!user && (user.admin? || record.recipe_user == user)
  end

  def destroy?
    update?
  end
end
