# frozen_string_literal: true

class AddPlanIdToFeatureUsage < ActiveRecord::Migration[7.0]
  def change
    add_column :feature_usages, :plan_id, :string, null: false, foreign_key: true, default: ''
  end
end
