class RecipeIngredientPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    update?
  end

  def update?
#    !!user && (user.admin? || record.try(:recipe).try(:user) == user)
    !!user && (user.admin? || record.recipe.user == user)
  end
end
