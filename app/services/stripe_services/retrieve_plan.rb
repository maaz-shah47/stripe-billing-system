# frozen_string_literal: true

module StripeServices
  class RetrievePlan
    def initialize(plan_id)
      @plan_id = plan_id
    end

    def retrieve_plan
      Stripe::Plan.retrieve(@plan_id) if @plan_id.present?
    end
  end
end
