# frozen_string_literal: true

class AddCustomerIdToFeatureUsage < ActiveRecord::Migration[7.0]
  def change
    add_column :feature_usages, :customer_id, :string, null: false, foreign_key: true, default: ''
  end
end
