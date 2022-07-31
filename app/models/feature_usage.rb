# frozen_string_literal: true

class FeatureUsage < ApplicationRecord
  belongs_to :user
  belongs_to :feature
  belongs_to :plan
end
