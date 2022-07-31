# frozen_string_literal: true

module CheckoutsHelper
  def get_customer(customer)
    StripeServices::RetrieveCustomer.new(customer).retrieve_customer
  end

  def get_product(product)
    Stripe::Product.retrieve(product)
  end
end
