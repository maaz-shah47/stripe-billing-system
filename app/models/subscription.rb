# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :user
  validates :usage, length: { minimum: 0 }

  paginates_per 10
end
