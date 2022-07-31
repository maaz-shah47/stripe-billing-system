# frozen_string_literal: true

module StripeServices
  class RetrieveSubscription
    def initialize(subscription)
      @subscription = subscription
    end

    def retrieve_subscription
      Stripe::Subscription.retrieve(@subscription)
    end
  end
end
