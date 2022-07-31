# frozen_string_literal: true

class AddProductIdToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :product_id, :string, null: false, foreign_key: true, default: ''
  end
end
