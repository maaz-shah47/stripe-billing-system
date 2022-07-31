# frozen_string_literal: true

class AddUsageToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :usage, :integer, default: 0
  end
end
