# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    NewUserMailer.with(resource).welcome_email.deliver_now unless resource.invalid?
  end
end
