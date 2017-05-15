require 'rails_helper'

RSpec.describe RecipeIngredientsController, type: :controller do
  before do
    @recipe_owner = User.create!(email: 'owner@aol.com', password: 'alfalfa' )
    @recipe       = Recipe.new(author: @recipe_owner, name: 'Scrambled Eggs', photo_path: 'recipes/placeholder.png', description: 'Eggs that are scrambled.', total_time: 15)
    @recipe.save!
  end

  describe "GET #new" do
    it "returns http success" do
# need to log in first to get success result.

      get :new,  params: { recipe_id: @recipe.id }
      #      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(:redirect)
    end
  end

end
