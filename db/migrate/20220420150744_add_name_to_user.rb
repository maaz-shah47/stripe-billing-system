# frozen_string_literal: true

# migration to add name field into users model
class AddNameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, unique: true
  end
end
