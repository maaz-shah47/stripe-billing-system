# frozen_string_literal: true

module PlansHelper
  def des_plan(plan, sub)
    is_present = false
    sub.each do |s|
      is_present = true if s.plan_id == plan.price_id
    end
    is_present
  end
end
