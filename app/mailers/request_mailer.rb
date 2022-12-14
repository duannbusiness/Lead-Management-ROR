# frozen_string_literal: true

class RequestMailer < ApplicationMailer
  default from: 'saadullah2051@gmail.com'

  def phase_add_manager_invitation(user, phase)
    @phase = phase
    @user = user
    mail(to: user.email, subject: 'Registered')
  end

  def user_registration(user)
    @user = user
    mail(to: user[:email], subject: 'Registered')
  end
end
