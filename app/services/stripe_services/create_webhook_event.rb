# frozen_string_literal: true

module StripeServices
  class CreateWebhookEvent
    def initialize(payload, head, endpoint_secret)
      @payload = payload
      @head = head
      @endpoint_secret = endpoint_secret
    end

    def create_event
      Stripe::Webhook.construct_event(
        @payload, @head, @endpoint_secret
      )
    end
  end
end
