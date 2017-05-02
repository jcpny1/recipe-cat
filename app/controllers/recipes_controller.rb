class RecipesController < ApplicationController

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @recipes = RecipePolicy::Scope.new(@user, Recipe).user_only.order(:name)
      @user_recipes = true
    else
      @recipes = policy_scope(Recipe).order(:name)
    end

# fix this up. just filter existing @recipes. Don't refetch.
    if user_signed_in? && !session[:ingredient_filter].blank?  # filter by ingredient selection.
      recipe_ingredients = RecipeIngredient.where(ingredient_id: session[:ingredient_filter])
      @recipes = recipe_ingredients.collect { |ri| ri.recipe }
      @recipes.uniq!
      @recipes.sort! { |recipe_1,recipe_2| recipe_1.name <=> recipe_2.name }
    end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    authorize @recipe
  end

  def new
    @recipe = Recipe.new
    authorize @recipe
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    authorize @recipe
    @recipe.total_time ||= 0
    @recipe.photo_path = 'recipes/placeholder.png'
    if @recipe.save
      redirect_to @recipe
    else
      flash[:alert] = @recipe.errors.full_messages
      render :new
    end
  end

  def edit
    @recipe = Recipe.find_by(id: params[:id])
    authorize @recipe
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    authorize @recipe
    if Recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash[:alert] = @recipe.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    recipe = Recipe.find_by(id: params[:id])
    authorize recipe
    recipe.destroy
    redirect_to request.referer
  end

private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :total_time, :favorite)
  end

end
