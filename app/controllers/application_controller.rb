class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized,    except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only:   :index
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception

  before_action      :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def about
    skip_authorization
  end

  def welcome
    skip_authorization
  end

private

  def render_404
    render :template => "404", :status => 404
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
