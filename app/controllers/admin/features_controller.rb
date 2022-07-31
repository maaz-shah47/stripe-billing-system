# frozen_string_literal: true

module Admin
  # Features controller
  class FeaturesController < ApplicationController
    layout 'main'
    before_action :authenticate_user!

    before_action :auth_user, only: %i[new create edit update destroy]
    before_action :build_feature, only: %i[create]
    before_action :destroy_feature_usage, only: %i[destroy]

    def index
      @plan = Plan.find(params[:plan_id])
      @features = @plan.features
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    end

    def show
      @feature = Feature.find(params[:id])
      @plan = current_user.plans.find(params[:plan_id])
    end

    def new
      @user = current_user
      @plan = @user.plans.find(params[:plan_id])

      @feature = @plan.features.build
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    end

    def create
      @feature.user = current_user
      if @feature.update(feature_params)
        redirect_to plan_features_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @plan = current_user.plans.find(params[:plan_id])
      @feature = Feature.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    end

    def update
      @feature = Feature.find(params[:id])
      if @feature.update(feature_params)
        redirect_to plan_features_path
      else
        render :edit, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    end

    def destroy
      @feature.destroy
      redirect_to plan_features_path, status: :see_other
    rescue StandardError
      render json: {}, status: :not_found
    end

    private

    def auth_user
      authorize current_user
    end

    def feature_params
      params.require(:feature).permit(:name, :code, :unit_price, :max_unit_limit)
    end

    def build_feature
      plan = Plan.find(params[:plan_id])
      @feature = plan.features.build
      @feature
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    end

    def destroy_feature_usage
      ActiveRecord::Base.transaction do
        @feature = Feature.find(params[:id])
        feature_usage = FeatureUsage.find_by(feature_id: @feature)
        feature_usage.destroy if feature_usage.present?
      end
    end
  end
end
