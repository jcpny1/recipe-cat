describe 'Feature Test: Ingredient', :type => :feature do

  describe 'Ingredient List' do
    before(:each) do
      @water = Ingredient.find_by(name: 'Water')
      visit ingredients_path
    end

    it 'has a page title' do
      expect(page).to have_content 'Ingredients'
    end

    it 'lists water as an ingredient' do
      expect(page).to have_content @water.name
    end

    it 'links to detail page' do
      expect(page).to have_link @water.name
    end
  end

  describe 'Ingredient Detail' do
    it 'has detail page' do
      @water = Ingredient.find_by(name: 'Water')
      visit ingredient_path @water
      expect(page).to have_content @water.name
      expect(page).to have_css('h3', text: @water.name)
      expect(page).to have_xpath("//img[contains(@src, 'ingredients/water')]")
    end
  end
end
