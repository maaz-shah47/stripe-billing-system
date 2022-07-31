# frozen_string_literal: true

# Invoice mailer class
class InvoiceMailer < ApplicationMailer
  def send_invoice
    @amount = params[:amount] / 100
    @email = params[:email]
    @name = params[:name]
    @inv_pdf = params[:inv_pdf]

    mail(to: @email, subject: 'Subscription Invoice')
  end
end
