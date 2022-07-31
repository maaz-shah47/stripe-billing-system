# frozen_string_literal: true

class FeatureUsageJob < ApplicationJob
  queue_as :default
  include Expiry

  def perform(*_args)
    @features = FeatureUsage.all

    @features.each do |f|
      day = days_left(f.billing_date)
      next unless day <= 0

      feature = Feature.find(f.feature_id)
      next unless (feature.max_unit_limit - f.usage).negative?

      exceed_usage = f.usage - feature.max_unit_limit
      Stripe::Charge.create({
                              amount: exceed_usage * feature.unit_price,
                              currency: 'usd',
                              customer: f.customer_id
                            })
    end
  end
end
