# frozen_string_literal: true

class CreateFeatureUsages < ActiveRecord::Migration[7.0]
  def change
    create_table :feature_usages do |t|
      t.string :user_id, null: false
      t.string :feature_id, null: false
      t.integer :usage, default: 0, null: false

      t.timestamps
    end
  end
end
