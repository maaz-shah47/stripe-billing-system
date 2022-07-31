# frozen_string_literal: true

# Checkout controller
class CheckoutsController < ApplicationController
  layout 'main'
  before_action :authenticate_user!
  before_action :stripe_session, only: [:create]

  def create
    ActiveRecord::Base.transaction do
      Subscription.create(product_id: @plan_id, user_id: current_user.id)
      redirect_to @session.url, allow_other_host: true
    end
  end

  def success
    session = StripeServices::RetrieveCheckoutSession.new(params[:session_id]).retrieve_checkout_session
    @customer = StripeServices::RetrieveCustomer.new(session.customer).retrieve_customer
  end

  private

  def stripe_session
    @price = params[:price_id]
    @plan_id = params[:plan_id]
    @session = StripeServices::CreateCheckoutSession.new(stripe_id: current_user.stripe_id, user_id: current_user.id, plan_id: @plan_id,
                                                         price: @price, root_url: root_url, plans_url: plans_url).create_checkout_session
  end
end
