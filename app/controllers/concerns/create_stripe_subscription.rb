# frozen_string_literal: true

module CreateStripeSubscription
  extend ActiveSupport::Concern

  included do
    def create_stripe_subscription(stripe_subscription, user, product_id)
      s = Subscription.where(user_id: user.id, product_id: product_id)
      s.update!(
        customer_id: stripe_subscription.customer,
        current_period_start: Time.zone.at(stripe_subscription.current_period_start).to_datetime,
        current_period_end: Time.zone.at(stripe_subscription.current_period_end).to_datetime,
        plan_id: stripe_subscription.plan.id,
        interval: stripe_subscription.plan.interval,
        status: stripe_subscription.status,
        subscription_id: stripe_subscription.id,
        user: user
      )
    end
  end
end
