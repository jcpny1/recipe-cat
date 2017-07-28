require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  before do

    @user = User.create!(email: "user@example.org", password: "very-secret")
    sign_in @user

    Recipe.destroy_all
    @recipe_attributes = {user_id: @user.id, name: "Test Recipe", photo_path: "dummy.png", description: "Yum!", total_time: 15}
  end

  describe "RECIPE create" do

    it 'creates a new recipe' do
      post :create, params: {recipe: @recipe_attributes}
      # expect(response).to redirect_to(recipe_path(6))
      expect(response).to redirect_to assigns[:recipe]
      expect(Recipe.count).to eq 1
    end

  end

  describe "GET show" do
    it 'returns a JSON representation of the product' do
      recipe = Recipe.create(@recipe_attributes)
      get :show, params: { id: recipe.id }, format: 'json'
      body = JSON.parse(response.body)["data"]["attributes"]
      expect(body["name"]).to eq recipe.name
      expect(body["photo-path"]).to eq recipe.photo_path
      expect(body["description"]).to eq recipe.description
      expect(body["total-time"]).to eq recipe.total_time
      expect(body["created_at"]).to eq nil
    end
  end

end
