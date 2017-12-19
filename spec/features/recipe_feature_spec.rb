describe 'Feature Test: Recipe', :type => :feature do
  # Scenario: User, as a guest (i.e. is not signed in), can view any recipe.
  #   Given I exist as a user,
  #   And I am not signed in,
  #   When I attempt to view a recipe,
  #   I can see the recipe.
  scenario "User not signed in can view a recipe" do
    recipe = FactoryBot.create(:recipe)
  end

  # Scenario: User, as a guest (i.e. is not signed in), cannot delete any recipe.
  #   Given I exist as a user,
  #   And I am not signed in,
  #   There is no delete recipe option available.
  scenario "User not signed in cannot delete a recipe" do
    recipe = FactoryBot.create(:recipe)
  end

  # Scenario: User, as a guest (i.e. is not signed in), cannot edit any recipe.
  #   Given I exist as a user,
  #   And I am not signed in,
  #   There is no edit recipe option available.
  scenario "User not signed in cannot edit a recipe" do
    recipe = FactoryBot.create(:recipe)
  end
end
