# frozen_string_literal: true

module UsersHelper
  def check_invitation?(user)
    user.created_by_invite? && !user.invitation_accepted?
  end
end
