# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'maaz.shah@devsinc.com'
  layout 'mailer'
end
