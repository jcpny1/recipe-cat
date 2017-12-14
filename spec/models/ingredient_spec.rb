require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  before do
    @ingredient1  = Ingredient.create!(name: 'Duck Eggs',   photo_path: 'ingredients/placeholder.jpg', description: 'A chicken egg.')
    @ingredient2  = Ingredient.create!(name: 'Goat Butter', photo_path: 'ingredients/placeholder.jpg', description: 'salted, made from cream.')
    @recipe_owner = User.create!(email: 'owner@aol.com', password: 'alfalfa' )
    @recipe       = Recipe.create!(user_id: @recipe_owner.id, name: 'Scrambled Eggs', photo_path: 'recipes/placeholder.png', description: 'Eggs that are scrambled.', total_time: 15)
    @recipe.recipe_ingredients.create!(ingredient_id: @ingredient1.id, quantity: 1, unit: nil)
    @recipe.recipe_ingredients.create!(ingredient_id: @ingredient2.id, quantity: 3, unit: nil)
  end

  it 'has a name' do
    expect(@ingredient1.name).to eq('Duck Eggs')
  end

  it 'has a recipe' do
    expect(@ingredient1.recipes).to include(@recipe)
  end
end
