# frozen_string_literal: true

class SubscriptionMailer < ApplicationMailer
  def payment_failed
    @user = params[:user]
    mail to: @user.email, subject: 'Payment Attemp Failed'
  end
end
