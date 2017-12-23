require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  before do
    @user = User.create!(email: "user@example.org", password: "very-secret")
    sign_in @user
    Recipe.destroy_all
    @recipe_attributes = {user_id: @user.id, name: "Test Recipe", photo_path: "dummy.png", description: "Yum!", total_time: 15}
  end

  describe "GET #index" do
    it "returns all recipes" do
      recipe = Recipe.create(@recipe_attributes)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it 'returns a JSON representation of a recipe' do
      recipe = Recipe.create(@recipe_attributes)
      get :show, params: { id: recipe.id }, format: 'json'
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body)["data"]["attributes"]
      expect(body["name"]).to eq recipe.name
      expect(body["photo-path"]).to eq recipe.photo_path
      expect(body["description"]).to eq recipe.description
      expect(body["total-time"]).to eq recipe.total_time
      expect(body["created_at"]).to eq nil
    end
  end

  describe "POST #create" do
    it 'creates a recipe' do
      post :create, params: {recipe: @recipe_attributes}
      # expect(response).to redirect_to(recipe_path(6))
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to assigns[:recipe]
      expect(Recipe.count).to eq 1
    end
  end

  describe "PATCH #update" do
    it "updates a recipe" do
      recipe = Recipe.create(@recipe_attributes)
      patch :update, { params: { id: recipe.id, recipe: { name: 'New Recipe' } } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to assigns[:recipe]
    end
  end

  describe "DELETE #destroy" do
    it "deletes a recipe" do
      recipe = Recipe.create(@recipe_attributes)
      get :index
      expect(response).to have_http_status(:success)
      delete :destroy, { params: { id: recipe.id } }
      expect(response).to have_http_status(:redirect)
    end
  end
end
