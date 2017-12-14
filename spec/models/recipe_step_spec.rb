require 'rails_helper'

RSpec.describe RecipeStep, type: :model do
  before do
    @recipe_owner = User.create!(email: 'owner@aol.com', password: 'alfalfa' )
    @recipe       = Recipe.new(author: @recipe_owner, name: 'Scrambled Eggs', photo_path: 'recipes/placeholder.png', description: 'Eggs that are scrambled.', total_time: 15)
    @recipe_step  = @recipe.recipe_steps.new(step_number: 1, description: 'Get an egg.')
    @recipe.save!
  end

  it 'has a recipe' do
    expect(@recipe_step.recipe).to eq(@recipe)
  end

  it 'has a step number' do
    expect(@recipe.recipe_steps.first.step_number).to eq(1)
  end
end
