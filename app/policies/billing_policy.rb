# frozen_string_literal: true

class BillingPolicy < BasePolicy
  attr_reader :user, :plan

  def initialize(user, plan)
    super
    @user = user
    @plan = plan
  end

  def create?
    @user.buyer?
  end
end
