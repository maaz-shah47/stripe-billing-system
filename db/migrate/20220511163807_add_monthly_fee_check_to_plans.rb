# frozen_string_literal: true

class AddMonthlyFeeCheckToPlans < ActiveRecord::Migration[7.0]
  def change
    add_check_constraint :plans, 'monthly_fee >= 0', null: false, default: 0
  end
end
