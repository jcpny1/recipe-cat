class UserIngredientsController < ApplicationController
  def index
    @user_ingredients = UserIngredient.joins(:user).where(user_id: 1)
  end
end
