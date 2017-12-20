# a set of instructions for preparing a particular dish, including a list of the ingredients required.
class Recipe < ApplicationRecord
  belongs_to :author, class_name: :User, foreign_key: :user_id

  has_many :recipe_ingredients,    dependent: :destroy, inverse_of: :recipe
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_reviews,        dependent: :destroy
  has_many :user_recipe_favorites, dependent: :destroy
  has_many :recipe_steps,          dependent: :destroy, inverse_of: :recipe

  validates :name, presence:   true
  validates :name, uniqueness: true

  accepts_nested_attributes_for :recipe_ingredients, :allow_destroy => true
  accepts_nested_attributes_for :recipe_steps, reject_if: proc { |attributes| attributes['step_number'].blank? }, :allow_destroy => true

  #do not allow total_time or photo_path to be null.
  after_initialize do |recipe|
    recipe.total_time ||= 0
    recipe.photo_path ||= 'recipes/placeholder.png'
  end

  # returns the total of the star ratings divided by the number of reviews.
  def average_stars
    sum = recipe_reviews.sum { |urr| urr.stars }
    number_of_reviews != 0 ? (sum.to_f / number_of_reviews).floor : 0
  end

  # Is this recipe a favorite of this user.
  def favorite?(user_id)
    self.user_recipe_favorites.exists?(user_id: user_id)
  end

  # returns a list of recipes that contain the specified ingredient.
  def self.filter_array_by_ingredient(recipes, ingredient_id)
    recipes.find_all { |recipe|
      recipe.recipe_ingredients.find_by(ingredient_id: ingredient_id)
    }
  end

  # returns a list of recipes that were created by the specified user.
  def self.filter_array_by_user(recipes, user_id)
    recipes.find_all { |recipe| recipe.user_id == user_id.to_i }
  end

  # returns the number of reviews for this recipe.
  def number_of_reviews
    recipe_reviews.size
  end

  # returns the name of the user that created this recipe.
  def author_name
    author.email
  end
end
