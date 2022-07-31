# frozen_string_literal: true

# Migration to generate features model
class CreateFeatures < ActiveRecord::Migration[7.0]
  def change
    create_table :features do |t|
      t.string :name, null: false
      t.string :code, unique: true, null: false
      t.decimal :unit_price
      t.integer :max_unit_limit

      t.timestamps
    end
  end
end
