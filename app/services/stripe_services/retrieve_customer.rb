# frozen_string_literal: true

module StripeServices
  class RetrieveCustomer
    def initialize(customer)
      @customer = customer
    end

    def retrieve_customer
      Stripe::Customer.retrieve(@customer)
    end
  end
end
