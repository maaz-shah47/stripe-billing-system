# frozen_string_literal: true

# Billings controller
class BillingsController < ApplicationController
  before_action :authenticate_user!
  before_action :billing_session, only: :create

  def create
    redirect_to @session.url, allow_other_host: true
  end

  private

  def billing_session
    @session = StripeServices::CreateBillingPortalSession.new(current_user.stripe_id, root_url).create_billing_portal
  end
end
