class UserRecipeReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end

    def recipe_only(for_recipe)
      scope.where(recipe_id: for_recipe.id)
    end

    def user_only(for_user)
      scope.where(user_id: for_user.id)
    end
  end
end
