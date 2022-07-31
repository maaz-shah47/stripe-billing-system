# frozen_string_literal: true

module UpdateStripeSubscription
  extend ActiveSupport::Concern

  included do
    def update_stripe_subscription(stripe_subscription, subscription)
      subscription.update(
        current_period_start: Time.zone.at(stripe_subscription.current_period_start).to_datetime,
        current_period_end: Time.zone.at(stripe_subscription.current_period_end).to_datetime,
        plan_id: stripe_subscription.plan.id,
        interval: stripe_subscription.plan.interval,
        status: stripe_subscription.status
      )
    end
  end
end
