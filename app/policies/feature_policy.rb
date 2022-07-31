# frozen_string_literal: true

class FeaturePolicy < BasePolicy
  attr_reader :user, :feature

  def initialize(user, feature)
    super
    @user = user
    @feature = feature
  end
end
