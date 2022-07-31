# frozen_string_literal: true

# Migration to add stripe_id to Users table
class AddStripeIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :stripe_id, :string, foreign_key: true
  end
end
