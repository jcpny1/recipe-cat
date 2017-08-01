require 'rails_helper'

RSpec.describe RecipeIngredientsController, type: :controller do
  before do
    @recipe_owner = User.create!(email: 'owner@aol.com', password: 'alfalfa' )
    @ingredient   = Ingredient.create(name: 'alfalfa', photo_path: '', description: 'green stuff')
    @recipe       = Recipe.new(author: @recipe_owner, name: 'Scrambled Eggs', photo_path: 'recipes/placeholder.png', description: 'Eggs that are scrambled.', total_time: 15)
    ri = @recipe.recipe_ingredients.new
    ri.ingredient = @ingredient
    ri.quantity = 1
    @recipe.save!
  end

  # for #new, need to log in first to get success result.
  # expect(response).to have_http_status(:success)
  describe "GET #index" do
    it "returns http success" do
      get :index, params: { recipe_id: @recipe.id }
      expect(response).to have_http_status(:success)
    end
  end

end
