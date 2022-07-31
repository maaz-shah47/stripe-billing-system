# frozen_string_literal: true

module SubscriptionsHelper
  def get_plan(plan_id)
    StripeServices::RetrievePlan.new(plan_id).retrieve_plan
  end

  def get_product(product)
    StripeServices::RetrieveProduct.new(product).retrieve_product
  end
end
