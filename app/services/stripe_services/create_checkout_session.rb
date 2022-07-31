# frozen_string_literal: true

module StripeServices
  class CreateCheckoutSession
    def initialize(params)
      @stripe_id = params[:stripe_id]
      @user_id = params[:user_id]
      @plan_id = params[:plan_id]
      @price = params[:price]
      @root_url = params[:root_url]
      @plans_url = params[:plans_url]
    end

    def create_checkout_session
      Stripe::Checkout::Session.create(
        customer: @stripe_id,
        client_reference_id: @user_id,
        success_url: "#{@root_url}success?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: @plans_url,
        payment_method_types: ['card'],
        mode: 'subscription',
        metadata: {
          product_id: @plan_id
        },
        line_items: [{
          quantity: 1,
          price: @price
        }]
      )
    end
  end
end
