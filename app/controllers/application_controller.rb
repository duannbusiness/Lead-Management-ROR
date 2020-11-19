# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_user!
  layout :set_layout

  private

  def user_not_authorized
    flash[:error] = t 'You are not authorize to do this action', scope: 'pundit', default: :default
    redirect_to(request.referer || root_path)
  end

  def set_layout
    user_signed_in? ? 'application' : 'login'
  end
end
