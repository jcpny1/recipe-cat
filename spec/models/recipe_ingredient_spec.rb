require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  before do
    @ingredient1  = Ingredient.create!(name: 'Duck Eggs',   photo_path: 'ingredients/placeholder.jpg', description: 'A chicken egg.')
    @recipe_owner = User.create!(email: 'owner@aol.com', password: 'alfalfa' )
    @recipe       = Recipe.create!(user_id: @recipe_owner.id, name: 'Scrambled Eggs', photo_path: 'recipes/placeholder.png', description: 'Eggs that are scrambled.', total_time: 15)
    @recipe.recipe_ingredients.create!(ingredient_id: @ingredient1.id, quantity: 1, unit: nil)
  end

  it 'has a recipe' do
    expect(@ingredient1.recipes.first).to eq(@recipe)
  end

  it 'has an ingredient' do
    expect(@recipe.ingredients.first).to eq(@ingredient1)
  end
end
