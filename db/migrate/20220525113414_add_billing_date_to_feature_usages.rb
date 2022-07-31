# frozen_string_literal: true

class AddBillingDateToFeatureUsages < ActiveRecord::Migration[7.0]
  def change
    add_column :feature_usages, :billing_date, :datetime
  end
end
