# frozen_string_literal: true

# User mailer class
class NewUserMailer < ApplicationMailer
  def welcome_email
    @user = params
    mail(to: @user.email, subject: 'Welcome to our site')
  end
end
