# base Rails controller class
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

  # display the welcome page.
  def about
    skip_authorization
  end

  # returns picklist of entities available for recent item search.
  def recent_edits_select
    @entities = [['Ingredients', 'ingredients'], ['Recipes', 'recipes'], ['Reviews', 'recipe_reviews']]
  end

  # format recent edit date and redirect to display route.
  def recent_edits
    formatted_date = "#{params[:date][:year]}-#{params[:date][:month]}-#{params[:date][:day]}"
    redirect_to "/#{params[:entity]}/updated_after/#{formatted_date}"
  end

  # display welcome page.
  def welcome
    skip_authorization
    @user_name = current_user.email if user_signed_in?
  end

protected

  # common code for listing records created or updated after the specified date.
  def update_selector
    @date = DateTime.parse(params[:date]).next_day
    yield
    @date = DateTime.parse(params[:date]).strftime('%d-%^b-%Y')   #=> '19-NOV-2007'
    @updated_after = true
  end

private

  # display a not found page for improperly formatted ActiveRecord URLs.
  def render_404
    render :template => '404', :status => 404
  end

  # display an error message for missing Pundit policy methods.
  def route_not_defined
    flash[:alert] = 'Undefined policy route.'
    redirect_to(request.referrer || root_path)
  end

  # display an error message when user attempts Pundit policy-unauthorized actions.
  def user_not_authorized
    flash[:alert] = 'Unauthorized action.'
    redirect_to(request.referrer || root_path)
  end
end
