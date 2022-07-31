# frozen_string_literal: true

module StripeServices
  class UpdateProduct
    def initialize(plan, body)
      @plan = plan
      @body = body
    end

    def update_stripe_product
      Stripe::Product.update(
        @plan,
        @body
      )
    end
  end
end
