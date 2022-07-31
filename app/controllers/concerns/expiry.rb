# frozen_string_literal: true

module Expiry
  extend ActiveSupport::Concern

  included do
    def billing_day(created_at)
      ((created_at + 1.month) - DateTime.now).to_i / 1.day
    end

    def days_left(created_at)
      (created_at - DateTime.now).to_i / 1.day
    end
  end
end
