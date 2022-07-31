# frozen_string_literal: true

# Subscription Controller
class SubscriptionsController < ApplicationController
  layout 'main'
  before_action :auth_user, only: :index

  def index
    @subscriptions = Subscription.page params[:page]
  end

  private

  def auth_user
    authorize current_user
  end
end
