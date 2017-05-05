require 'rails_helper'

RSpec.describe RecipeReview, type: :model do
  before do
    @recipe_owner  = User.create!(email: 'owner@aol.com', password: 'alfalfa' )
    @recipe        = Recipe.new(user: @recipe_owner, name: 'Scrambled Eggs', photo_path: 'recipes/placeholder.png', description: 'Eggs that are scrambled.', total_time: 15)
    @review_author = User.create!(email: 'author@aol.com', password: 'sesame' )
    @recipe_review = @recipe.recipe_reviews.new(user: @review_author, stars: 5, title: 'Incredible!', comments: 'Best scrambled eggs on the planet!')
    @recipe.save!
  end

  it "has a recipe" do
    expect(@recipe_review.recipe).to eq(@recipe)
  end

  it "has a title" do
    expect(@recipe.recipe_reviews.first.title).to eq('Incredible!')
  end
end
