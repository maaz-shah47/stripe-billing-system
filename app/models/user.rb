# frozen_string_literal: true

class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_type, inclusion: { in: %w[admin buyer],
                                     message: 'user_type is not a valid size' }
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Email is not valid' }
  has_one_attached :avatar

  enum user_type: {
    admin: 1,
    buyer: 0
  }

  paginates_per 5

  after_create :new_user_email

  has_many :plans, dependent: :destroy
  has_many :features, through: :plans, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :feature_usages, dependent: :destroy

  def subscribed?
    subscriptions.where(status: 'active').any?
  end

  def new_user_email
    NewUserMailer.with(user: @user).welcome_email.deliver_later
  end
end
