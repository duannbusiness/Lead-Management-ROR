class ApplicationController < ActionController::Base
  layout :writers_and_readers

  private

  def writers_and_readers
    user_signed_in? ? 'application' : 'login'
  end
end
