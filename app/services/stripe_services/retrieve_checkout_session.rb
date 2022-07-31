# frozen_string_literal: true

module StripeServices
  class RetrieveCheckoutSession
    def initialize(session_id)
      @session_id = session_id
    end

    def retrieve_checkout_session
      Stripe::Checkout::Session.retrieve(@session_id)
    end
  end
end
