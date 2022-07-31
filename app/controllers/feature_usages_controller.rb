# frozen_string_literal: true

class FeatureUsagesController < ApplicationController
  include Expiry
  include CreateFeatureUsage

  before_action :check_for_feature_units, only: :create
  after_action :check_if_usage_exceeds, only: :create

  def create
    if get_feature_usages(current_user, @feature_id).empty?
      @feature = create_feature_usage(@user.id, @feature_id, @plan_id, @plan.current_period_end)
    else
      @feature = get_feature_usages(current_user, @feature_id).first
      @usage = @feature.usage.to_i + @usage.to_i
      @feature.update!(usage: @usage)
    end

    if @feature.present?
      redirect_to plan_features_path(@plan_id)
    else
      render :create, status: :unprocessable_entity
    end
  end

  private

  def plans_params
    params.require(:feature_usage).permit(:feature_id, :plan_id, :user_id, :usage, :billing_date, :customer_id)
  end

  def check_if_usage_exceeds
    flash[:notice] = 'Feature usage exceeded the maximum limit' if @feature_max_unit < @feature.usage
  end

  def get_feature_usages(user, f_id)
    FeatureUsage.where(user_id: user, feature_id: f_id)
  end

  def check_for_feature_units
    @user = current_user
    @feature_id = params[:feature_id]
    @plan_id = params[:plan_id]
    @usage = params[:usage]
    @feature_max_unit = Feature.find(@feature_id).max_unit_limit
    @plan = Subscription.where(user_id: @user.id, product_id: @plan_id).first
  end
end
