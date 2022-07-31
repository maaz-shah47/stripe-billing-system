# frozen_string_literal: true

FactoryBot.define do
  factory :feature do
    name  { Faker::Name.name }
    code { Faker::String.random(length: 3) }
    unit_price { Faker::Number.number(digits: 3) }
    max_unit_limit { Faker::Number.number(digits: 3) }
  end
end
