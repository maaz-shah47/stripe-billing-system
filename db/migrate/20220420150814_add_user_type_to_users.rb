# frozen_string_literal: true

# Migration to add userType field into Users table
class AddUserTypeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_type, :integer, default: 0
  end
end
