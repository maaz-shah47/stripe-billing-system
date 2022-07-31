# frozen_string_literal: true

# Migration to add priceId into plans
class AddPriceIdToPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :price_id, :string, null: false, foreign_key: true, default: ''
  end
end
