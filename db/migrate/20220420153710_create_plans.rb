# frozen_string_literal: true

# Migration to create plans model
class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :name, unique: true, index: true, null: false
      t.decimal :monthly_fee, null: false

      t.timestamps
    end
  end
end
