# frozen_string_literal: true

module StripeServices
  class CreatePrice
    def initialize(plan, product)
      @plan = plan
      @product = product
    end

    def create_stripe_price
      Stripe::Price.create(
        {
          unit_amount: (@plan.monthly_fee * 100).to_i,
          currency: 'usd',
          recurring: { interval: 'month' },
          product: @product.id
        }
      )
    end
  end
end
