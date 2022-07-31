# frozen_string_literal: true

module StripeServices
  class CreateBillingPortalSession
    def initialize(stripe_id, url)
      @stripe_id = stripe_id
      @url = url
    end

    def create_billing_portal
      Stripe::BillingPortal::Session.create(
        {
          customer: @stripe_id,
          return_url: @url
        }
      )
    end
  end
end
