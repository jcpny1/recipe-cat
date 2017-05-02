class RecipeIngredientPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    update?
  end

  def create?
    !!user && (user.admin? || record.recipe.user == user)
  end

  def update?
    !!user && (user.admin? || record.recipe.user == user)
  end

  def destroy?
    update?
  end
end
