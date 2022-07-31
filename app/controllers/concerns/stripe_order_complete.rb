# frozen_string_literal: true

module StripeOrderComplete
  extend ActiveSupport::Concern

  included do
    def fullfill_order(checkout_session)
      user = User.find(checkout_session.client_reference_id)
      product_id = checkout_session.metadata.product_id
      user.update(stripe_id: checkout_session.customer)
      stripe_subscription = StripeServices::RetrieveSubscription.new(checkout_session.subscription).retrieve_subscription

      create_stripe_subscription(stripe_subscription, user, product_id)
      inv = StripeServices::RetrieveInvoice.new(stripe_subscription.latest_invoice).retrieve_invoice

      InvoiceMailer.with(amount: inv.total, email: inv.customer_email, name: inv.customer_name,
                         inv_pdf: inv.invoice_pdf).send_invoice.deliver_later
    end

    def invoice_payment_success(event)
      return if event.data.object.subscription.blank?

      stripe_subscription = StripeServices::RetrieveSubscription.new(event.data.object.subscription).retrieve_subscription
      subscription = Subscription.find_by(subscription_id: stripe_subscription)
      update_stripe_subscription(stripe_subscription, subscription) if subscription.present?
    end

    def customer_subscription_updated(event)
      stripe_subscription = event.data.object

      return unless stripe_subscription.cancel_at_period_end == true

      subscription = Subscription.find_by(subscription_id: stripe_subscription.id)
      update_stripe_subscription(stripe_subscription, subscription) if subscription.present?
    end
  end
end
