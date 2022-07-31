# frozen_string_literal: true

module Admin
  # Plan controller
  class PlansController < ApplicationController
    layout 'main'
    before_action :authenticate_user!

    before_action :plan_name?, :plan_fee?, only: :create
    before_action :auth_user, only: %i[new create edit update destroy]
    before_action :stripe_product_price, only: %i[create]
    before_action :prouct_archive, only: %i[destroy]

    def index
      @plans = Plan.page params[:page]
      @sub = Subscription.where(customer_id: current_user.stripe_id)
    end

    def new
      @plan = Plan.new
    end

    def create
      ActiveRecord::Base.transaction do
        if @plan.save
          redirect_to plans_path
        else
          render :new, status: :unprocessable_entity
        end
      end
    end

    def edit
      @plan = Plan.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    end

    def update
      ActiveRecord::Base.transaction do
        begin
          @plan = Plan.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: {}, status: :not_found
        end

        begin
          if @plan.update(plans_params)
            redirect_to plans_path
          else
            render :edit, status: :unprocessable_entity
          end
        rescue StandardError
          render json: {}, status: :not_found
        end
      end
    end

    def destroy
      @plan.destroy

      redirect_to plans_path, status: :see_other
    end

    private

    def auth_user
      authorize current_user
    end

    def plans_params
      params.require(:plan).permit(:name, :monthly_fee)
    end

    def plan_name?
      plans_params[:name].present?
    end

    def plan_fee?
      plans_params[:monthly_fee].present?
    end

    def stripe_product_price
      @plan = current_user.plans.new(plans_params)

      return unless plan_name? && plan_fee?

      @product  = StripeServices::CreateProduct.new(@plan).create_stripe_product
      @price    = StripeServices::CreatePrice.new(@plan, @product).create_stripe_price
      @plan.product_id = @product.id
      @plan.price_id = @price.id
    end

    def prouct_archive
      begin
        @plan = Plan.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: {}, status: :not_found
      end
      StripeServices::UpdateProduct.new(@plan.product_id, { active: false }).update_stripe_product
      subscription = Subscription.find_by(product_id: @plan.id)
      subscription.destroy if subscription.present?
    end
  end
end
  