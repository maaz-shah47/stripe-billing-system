# frozen_string_literal: true

# Migration to add productId to Plans table
class AddProductIdToPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :product_id, :string, null: false, foreign_key: true, default: ''
  end
end
