# frozen_string_literal: true

FactoryBot.define do
  factory :plan do
    name { Faker::Name.name }
    monthly_fee { Faker::Number.number(digits: 3) }
    product_id { 'prod_Lw2uONgwITsjEM' }
    price_id { 'price_1LEAouEsynfDvne4gU7UuIfw' }
  end
end
