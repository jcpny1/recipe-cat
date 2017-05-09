class RecipeReviewsController < ApplicationController
  before_action     :get_recipe,           except: [:updated_after, :index]
  skip_after_action :verify_authorized,    only:   [:updated_after]
  after_action      :verify_policy_scoped, only:   [:updated_after]

  def updated_after   # list recipe reviews created or updated after the specified date.
    update_selector {
      @recipe_reviews = RecipeReview.sort_by_recipe_and_time(policy_scope(RecipeReview.updated_after(@date))) }
    render :index
  end

  def index
    if params[:user_id].present?
      user = User.find_by(id: params[:user_id])
      @recipe_reviews = policy_scope(RecipeReview).where(user_id: user.id)
      @user_name = user.email
      @user_reviews = true
    elsif params[:recipe_id].present?
      @recipe_id = params[:recipe_id]
      @recipe_reviews = policy_scope(RecipeReview).where(recipe_id: @recipe_id)
    end

    @recipe_reviews = RecipeReview.sort_by_recipe_and_time(@recipe_reviews)
  end

  def new
    @recipe_review = @recipe.recipe_reviews.new
    authorize @recipe_review
  end

  def create
    @recipe_review = @recipe.recipe_reviews.new(recipe_review_params)
    @recipe_review.user = current_user
    authorize @recipe_review
    if @recipe_review.save
      redirect_to recipe_recipe_reviews_path(@recipe)
    else
      flash.now[:alert] = @recipe_review.errors.full_messages
      render :new
    end
  end

  def edit
    @recipe_review = @recipe.recipe_reviews.find(params[:id])
    authorize @recipe_review
  end

  def update
    @recipe_review = @recipe.recipe_reviews.find(params[:id])
    authorize @recipe_review
    if @recipe_review.update(recipe_review_params)
      redirect_to recipe_recipe_reviews_path(@recipe)
    else
      flash.now[:alert] = @recipe_review.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    recipe_review = @recipe.recipe_reviews.find(params[:id])
    authorize recipe_review
    recipe_review.destroy
    redirect_to request.referer
  end

private

  def get_recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_name = @recipe.name
  end

  def recipe_review_params
    params.require(:recipe_review).permit(:stars, :title, :comments)
  end
end
