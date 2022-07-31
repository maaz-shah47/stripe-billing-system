# frozen_string_literal: true

require 'rails_helper'
require 'stripe_mock'

RSpec.describe Plan, type: :model do
  let(:user) { create(:user) }

  before do
    Stripe.api_key = Rails.application.credentials[:stripe][:secret_key]
  end

  subject do
    described_class.new(name: 'Anything',
                        monthly_fee: 10, user: user)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a monthly_fee' do
    subject.monthly_fee = nil
    expect(subject).to_not be_valid
  end

  it 'is valid if monthly_fee is greater than or equal to 1' do
    subject.monthly_fee = 2
    expect(subject).to validate_numericality_of(:monthly_fee).is_greater_than_or_equal_to(1)
  end

  it 'is not valid if monthly_fee not a number' do
    subject.monthly_fee = 'sadhk'
    expect(subject).to_not be_valid
  end

  it 'is not valid if monthly_fee is less than 1' do
    subject.monthly_fee = 0
    expect(subject).to_not be_valid
  end

  describe 'associations' do
    it 'should have many features' do
      t = Plan.reflect_on_association(:features)
      expect(t.macro).to eq(:has_many)
    end

    it 'should belong to user' do
      t = Plan.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  describe '#callback method' do
    let(:plan) { build(:plan, user: user) }
    it 'update stripe product' do
      plan.update({ name: 'plan updatedd' })
      product = StripeServices::UpdateProduct.new(plan.product_id,
                                                  { name: plan.name }).update_stripe_product
      allow_any_instance_of(Plan).to receive(:stripe_product_update).and_return(product)
      expect(product.name).to eq('plan updatedd')
    end
  end
end
