# frozen_string_literal: true

# Webhooks controller
class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  include CreateStripeSubscription
  include UpdateStripeSubscription
  include StripeOrderComplete

  CHECKOUT_SESSION_COMPLETED = 'checkout.session.completed'
  INVOICE_PAYMENT_SUCCEEDED = 'invoice.payment_succeeded'
  INVOICE_PAYMENT_FAILED = 'invoice.payment_failed'
  CUSTOMER_SUBSCRIPTION_UPDATED = 'customer.subscription.updated'
  CHECKOUT_SESSION_ASYNC_PAYMENT = 'checkout.session.async_payment_succeeded'

  def create
    payload = request.body.read
    signature_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials[:stripe][:webhook_signing_secret]
    event = nil

    begin
      event = StripeServices::CreateWebhookEvent.new(payload, signature_header, endpoint_secret).create_event
    rescue JSON::ParserError => e
      render json: { message: e }, status: :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      render json: { message: e }, status: :bad_request
      return
    end
    handle_event(event)
    render json: { message: 'success' }
  end

  private

  def handle_event(event)
    case event.type
    when CHECKOUT_SESSION_COMPLETED
      return unless User.exists?(event.data.object.client_reference_id)

      fullfill_order(event.data.object)

    when INVOICE_PAYMENT_SUCCEEDED
      invoice_payment_success(event)

    when INVOICE_PAYMENT_FAILED
      user = User.find_by(stripe_id: event.data.object.customer)
      SubscriptionMailer.with(user: user).payment_failed.deliver_later if user.present?

    when CUSTOMER_SUBSCRIPTION_UPDATED
      customer_subscription_updated(event)
    end
  end
end
