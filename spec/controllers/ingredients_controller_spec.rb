require 'rails_helper'

RSpec.describe IngredientsController, type: :controller do
  before do
    ingredient_attributes = {name: "Test Ingredient", photo_path: "egg.png", description: "a egg"}
    @ingredient = Ingredient.create(ingredient_attributes)
  end

  describe "GET #index" do
    it "returns all ingredients" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it 'returns an ingredient' do
      get :show, params: { id: @ingredient.id }
      expect(response).to have_http_status(:success)
    end
  end
end
