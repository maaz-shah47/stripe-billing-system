# frozen_string_literal: true

# Migration to add plans to features
class AddPlanToFeatures < ActiveRecord::Migration[7.0]
  def change
    add_reference :features, :plan, foreign_key: true
  end
end
