# frozen_string_literal: true

class AddUnitPriceCheckToFeatures < ActiveRecord::Migration[7.0]
  def change
    add_check_constraint :features, 'unit_price >= 0'
  end
end
