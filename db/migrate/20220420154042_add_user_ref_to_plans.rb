# frozen_string_literal: true

# Migration to add user reference to plans model
class AddUserRefToPlans < ActiveRecord::Migration[7.0]
  def change
    add_reference :plans, :user, foreign_key: true
  end
end
