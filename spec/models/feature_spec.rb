# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feature, type: :model do
  describe 'check validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:max_unit_limit) }
    it { should validate_numericality_of(:unit_price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:max_unit_limit).is_greater_than_or_equal_to(0) }
  end

  describe 'check associations' do
    it { is_expected.to belong_to(:plan) }
    it { is_expected.to belong_to(:user) }
  end
end
