class RecipeIngredientPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    user && (user.admin? || record.try(:recipe).try(:user) == user)
  end
end
