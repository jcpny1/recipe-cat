class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized,    except: [:recent_edits_select, :recent_edits, :index], unless: :devise_controller?
  after_action :verify_policy_scoped, only:   [:index]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::NotDefinedError,    with: :route_not_defined

  protect_from_forgery with: :exception

  before_action      :authenticate_user!
  skip_before_action :authenticate_user!, only: [:about, :welcome, :index, :show]

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def about
    skip_authorization
  end

  def recent_edits_select
    @entities = [['Ingredients', 'ingredients'], ['Recipes', 'recipes'], ['Reviews', 'recipe_reviews']]
  end

  def recent_edits
    date = "#{params[:date][:year]}-#{params[:date][:month]}-#{params[:date][:day]}"
    redirect_to "/#{params[:entity]}/updated_after/#{date}"
  end

  def welcome
    skip_authorization
    @user_name = current_user.email if user_signed_in?
  end

private

  def render_404
    render :template => "404", :status => 404
  end

  def route_not_defined
    flash[:alert] = "Undefined policy route."
    redirect_to(request.referrer || root_path)
  end

  def user_not_authorized
    flash[:alert] = "Unauthorized action."
    redirect_to(request.referrer || root_path)
  end
end
