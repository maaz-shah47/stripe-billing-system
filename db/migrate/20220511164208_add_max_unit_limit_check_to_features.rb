# frozen_string_literal: true

class AddMaxUnitLimitCheckToFeatures < ActiveRecord::Migration[7.0]
  def change
    add_check_constraint :features, 'max_unit_limit >= 0'
  end
end
