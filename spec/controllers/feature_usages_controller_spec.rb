# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FeatureUsages', type: :request do
  let(:user) { create(:user) }
  let!(:plan) { create(:plan, user: user) }
  let(:feature) { create(:feature, user: user, plan: plan) }

  let(:subscription_attr) do
    {
      plan_id: 'price_1LACMcEsynfDvne4QogNHjh2',
      customer_id: 'cus_LuydR0DKwMggoN',
      status: 'active',
      interval: 'month',
      subscription_id: 'sub_1LD8gdEsynfDvne4htiX18OG',
      current_period_start: '2022-06-21 15:08:15',
      current_period_end: '2022-07-21 15:08:15',
      product_id: plan.id,
      usage: 0
    }
  end

  let(:feature_usage_attr) do
    {
      billing_date: '2022-07-13 12:31:25',
      customer_id: 'cus_LuydR0DKwMggoN'
    }
  end

  before do
    sign_in user

    @subscription = user.subscriptions.create! subscription_attr
  end

  describe '#GET /create' do
    context 'if valid parameters provided' do
      it 'feature usage created successfully' do
        expect do
          post feature_usages_url, params: { feature_usage: feature_usage_attr, user_id: user,
                                             feature_id: feature.id,
                                             plan_id: plan.id }
        end.to change(FeatureUsage, :count).by(1)
        expect(FeatureUsage.last.customer_id).to eq('cus_LuydR0DKwMggoN')
      end

      it 'feature usage created and redirects successfully ' do
        post feature_usages_url, params: { feature_usage: feature_usage_attr, user_id: user,
                                           feature_id: feature.id,
                                           plan_id: plan.id }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(plan_features_path(plan))
      end
    end

    context 'if invalid paramters provided' do
      it 'feature usage not created successfully' do
        expect do
          post feature_usages_url, params: { feature_usage: feature_usage_attr,
                                             feature_id: feature.id,
                                             plan_id: plan.id }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
