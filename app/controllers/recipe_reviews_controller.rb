# Rails controller for ReceipeReviews model.
class RecipeReviewsController < ApplicationController
  before_action     :recipe,               except: %i[updated_after index]
  skip_after_action :verify_authorized,    only:   [:updated_after]
  after_action      :verify_policy_scoped, only:   [:updated_after]

  # display recipe reviews created or updated after the specified date.
  def updated_after
    update_selector { @recipe_reviews = RecipeReview.sort_by_recipe_and_time(policy_scope(RecipeReview.updated_after(@date))) }
    render :index
  end

  # display all recipe reviews, possibly filterer by author or recipe.
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
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @recipe_reviews }
    end
  end

  # display a specific recipe.
  def show
    @recipe_review = @recipe.recipe_reviews.find_by(id: params[:id])
    authorize @recipe_review
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @recipe_reviews }
    end
  end

  # prepare to create a new recipe review.
  def new
    @recipe_review = @recipe.recipe_reviews.new
    authorize @recipe_review
  end

  # add a new recipe review to a recipe.
  def create
    @recipe_review = @recipe.recipe_reviews.new(recipe_review_params)
    @recipe_review.author = current_user
    authorize @recipe_review
    if @recipe_review.save
      respond_to do |format|
        format.html { redirect_to recipe_recipe_reviews_path(@recipe) }
        format.json { render json: @recipe_review }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = @recipe_review.errors.full_messages
          render :new
        end
        format.json { render json: { errors: @recipe_review.errors.full_messages }, status: 422 }  # Unprocessable Entity
      end
    end
  end

  # edit a recipe review record.
  def edit
    @recipe_review = @recipe.recipe_reviews.find(params[:id])
    session[:review_update_return_path] ||= request.referer
    authorize @recipe_review
  end

  # commit recipe review edits to the database.
  def update
    @recipe_review = @recipe.recipe_reviews.find(params[:id])
    authorize @recipe_review
    if @recipe_review.update(recipe_review_params)
      return_path = session[:review_update_return_path]
      session.delete('review_update_return_path')
      redirect_to return_path
    else
      flash.now[:alert] = @recipe_review.errors.full_messages
      render 'edit'
    end
  end

  # remove a recipe review from a recipe and delete it.
  def destroy
    recipe_review = @recipe.recipe_reviews.find(params[:id])
    authorize recipe_review
    recipe_review.destroy
    redirect_to request.referrer
  end

private

  # load the recipe identified in the route.
  def recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_name = @recipe.name
  end

  # filter params for allowed elements only.
  def recipe_review_params
    params.require(:recipe_review).permit(:stars, :title, :comments)
  end
end
