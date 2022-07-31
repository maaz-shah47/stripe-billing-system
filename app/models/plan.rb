# frozen_string_literal: true

class Plan < ApplicationRecord
  belongs_to :user
  has_many :features, dependent: :destroy

  validates :name, presence: true
  validates :monthly_fee, presence: true
  validates :monthly_fee, numericality: { greater_than_or_equal_to: 1 }

  after_update :stripe_product_update

  paginates_per 12

  def stripe_product_update
    StripeServices::UpdateProduct.new(product_id, { name: name }).update_stripe_product
  end
end
