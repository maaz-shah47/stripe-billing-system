# frozen_string_literal: true

module StripeServices
  class RetrieveProduct
    def initialize(product)
      @product = product
    end

    def retrieve_product
      Stripe::Product.retrieve(@product)
    end
  end
end
