# frozen_string_literal: true

module CheckAdmin
  extend ActiveSupport::Concern

  included do
    def check_if_admin?
      current_user.admin?
    end
  end
end
