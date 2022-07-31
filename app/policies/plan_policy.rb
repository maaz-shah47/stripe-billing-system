# frozen_string_literal: true

class PlanPolicy < BasePolicy
  attr_reader :user, :plan

  def initialize(user, plan)
    super
    @user = user
    @plan = plan
  end
end
