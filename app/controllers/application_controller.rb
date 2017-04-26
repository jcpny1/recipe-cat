class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:about, :welcome]
  skip_after_action  :verify_authorized,  only: [:about, :welcome]

  def about
  end

  def welcome
  end

private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
