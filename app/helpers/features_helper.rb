# frozen_string_literal: true

module FeaturesHelper
  def usage_empty(user, feature)
    FeatureUsage.where(user_id: user, feature_id: feature).empty?
  end

  def find_usage(user, feature)
    FeatureUsage.where(user_id: user, feature_id: feature).first.usage
  end
end
