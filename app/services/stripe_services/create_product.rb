# frozen_string_literal: true

module StripeServices
  class CreateProduct
    def initialize(plan)
      @plan = plan
    end

    def create_stripe_product
      Stripe::Product.create({ name: @plan.name })
    end
  end
end
