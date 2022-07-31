# frozen_string_literal: true

# Migration for subscription model
class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :plan_id, null: false, index: true, default: ''
      t.string :customer_id, null: false, index: true, default: ''
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false, default: ''
      t.string :interval, null: false, default: ''
      t.string :subscription_id, null: false, index: true, default: ''

      t.datetime :current_period_start
      t.datetime :current_period_end

      t.timestamps
    end
  end
end
