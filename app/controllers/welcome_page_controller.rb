# frozen_string_literal: true

# Welcome page controller
class WelcomePageController < ApplicationController
  skip_before_action :authenticate_user!, on: [:index]

  def index; end
end
