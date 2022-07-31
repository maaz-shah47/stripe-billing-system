# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { 'admin007' }
    password_confirmation { 'admin007' }
    user_type { 1 }
    stripe_id { 'cus_LuydR0DKwMggoN' }
  end
end
