# frozen_string_literal: true

class Feature < ApplicationRecord
  belongs_to :plan
  belongs_to :user

  validates :name, presence: true
  validates :code, presence: true
  validates :unit_price, presence: true
  validates :max_unit_limit, presence: true
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }
  validates :max_unit_limit, numericality: { greater_than_or_equal_to: 0 }
end
