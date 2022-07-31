# frozen_string_literal: true

require 'rails_helper'
require 'admin/features_controller'

RSpec.describe 'Features', type: :request do
  let(:user) { create(:user) }
  let!(:plan) { create(:plan, user: user) }
  let!(:feature) { create(:feature, user: user, plan: plan) }

  let(:valid_feature_params) do
    {
      name: 'feature valid',
      code: 'VF',
      unit_price: 20,
      max_unit_limit: 200,
      user: user,
      plan_id: plan.id
    }
  end

  let(:invalid_feature_params) do
    {
      name: '',
      code: 'VF',
      unit_price: 20,
      max_unit_limit: 200,
      user: user,
      plan_id: plan.id
    }
  end

  before do
    sign_in user
  end

  describe '#GET /index' do
    context 'for successful response' do
      it 'render successful response' do
        get plan_features_url(plan)
        expect(response).to be_successful
      end
    end
  end

  describe '#GET /new' do
    it 'feature new action render successful response' do
      get new_plan_url

      expect(response).to be_successful
      expect(response).to have_http_status(:success)
    end
  end

  describe '#GET /create' do
    context 'if valid feature parameters provided' do
      it 'new feature created successfully' do
        expect do
          post plan_features_url(plan), params: { feature: valid_feature_params }
        end.to change(Feature, :count).by(1)

        feature = Feature.last

        expect(feature.name).to eq('feature valid')
        expect(feature.unit_price).to eq(20)
      end

      it 'after feature created redirect successful response' do
        post plan_features_url(plan), params: { feature: valid_feature_params }
        expect(response).to redirect_to(plan_features_url(plan))
      end
    end
  end

  describe '#GET /edit' do
    context 'for valid featue id render success response' do
      it 'edit action render successful response' do
        get edit_plan_feature_url(plan, feature)
        expect(response).to be_successful
      end
    end

    context 'for invalid feature id' do
      it 'passing invalid feature id to get not_found response' do
        get edit_plan_url(300_000)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#PATCH /update' do
    let(:update_attr) do
      {
        name: 'feature updated'
      }
    end

    let(:invalid_update_attr) do
      {
        name: 'dfsd'
      }
    end

    context 'for valid feature params' do
      it 'feature updated successfully' do
        feature = create(:feature, user: user, plan: plan)
        patch plan_feature_url(plan, feature), params: { feature: update_attr }
        feature.reload

        expect(feature.name).to eq('feature updated')
      end

      it 'feature updated successfully and redirect to features path' do
        patch plan_feature_url(plan, feature), params: { feature: update_attr }
        expect(response).to redirect_to(plan_features_url(plan))
      end
    end

    context 'for invalid feature id' do
      it 'passing invalid feature id to get not_found response' do
        get edit_plan_url(300_000)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#DELETE /destroy' do
    context 'destroy feature successfully' do
      it 'destroy feature susccessfully' do
        expect { delete plan_feature_url(plan, feature) }.to change(Feature, :count).by(-1)
      end
    end

    context 'destroy and give success response' do
      it 'destroy feature and redirect to plans path successfully' do
        delete plan_feature_url(plan, feature)

        expect(response).to redirect_to(plan_features_url(plan))
      end
    end

    context 'redirect to #edit' do
      it 'passing invalid plan id to get not_found response' do
        get edit_plan_url(300_000)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
