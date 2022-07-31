# frozen_string_literal: true

module CreateFeatureUsage
  extend ActiveSupport::Concern

  included do
    def create_feature_usage(user_id, feature_id, plan_id, date)
      user = User.find(user_id)
      FeatureUsage.create!(user_id: user_id, feature_id: feature_id, plan_id: plan_id,
                           billing_date: date, customer_id: user.stripe_id)
    end
  end
end
