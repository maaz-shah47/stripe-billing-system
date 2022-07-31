# frozen_string_literal: true

module StripeServices
  class RetrieveInvoice
    def initialize(invoice)
      @invoice = invoice
    end

    def retrieve_invoice
      Stripe::Invoice.retrieve(@invoice)
    end
  end
end
