# frozen_string_literal: true

module SharedHelper
  def user_avatar(user)
    user = User.find(user.id)
    if user.avatar.attached?
      image_tag user.avatar, class: 'img-fluid nav-avatar'
    else
      image_tag 'gravatar.png', class: 'img-fluid nav-avatar'
    end
  end

  delegate :admin?, to: :current_user

  delegate :buyer?, to: :current_user
end
