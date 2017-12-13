require 'rails_helper'

RSpec.describe UserRecipeFavorite, type: :model do
  before do
    @ingredient1  = Ingredient.create!(name: 'Duck Eggs',   photo_path: 'ingredients/placeholder.jpg', description: 'A chicken egg.')
    @ingredient2  = Ingredient.create!(name: 'Goat Butter', photo_path: 'ingredients/placeholder.jpg', description: 'salted, made from cream.')
    @recipe_owner = User.create!(email: 'owner@aol.com', password: 'alfalfa' )
    @recipe       = Recipe.new(author: @recipe_owner, name: 'Scrambled Eggs', photo_path: 'recipes/placeholder.png', description: 'Eggs that are scrambled.', total_time: 15)
    @recipe.recipe_ingredients.new(ingredient: @ingredient1, quantity: 1, unit: nil)
    @recipe.recipe_ingredients.new(ingredient: @ingredient2, quantity: 3, unit: nil)
    @review_author = User.create!(email: 'author@aol.com', password: 'sesame' )
    @recipe_review = @recipe.recipe_reviews.new(author: @review_author, stars: 5, title: 'Incredible!', comments: 'Best scrambled eggs on the planet!')
    @user_recipe_favorite = @recipe.user_recipe_favorites.new(user: @review_author, recipe: @recipe)
    @recipe.save!
  end

  it 'has a recipe' do
    expect(@user_recipe_favorite.recipe).to eq(@recipe)
  end

  it 'has a user' do
    expect(@user_recipe_favorite.user).to eq(@review_author)
  end
end
