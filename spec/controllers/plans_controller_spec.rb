# frozen_string_literal: true

require 'rails_helper'
require 'admin/plans_controller'

RSpec.describe 'Plans', type: :request do
  let(:user) { create(:user) }
  let!(:plan) { create(:plan, user: user) }
  let!(:stripe_helper) { StripeMock.create_test_helper }

  let(:valid_plan_params) do
    {
      name: 'Valid Plan',
      monthly_fee: 20,
      product_id: 'prod_Lw2uONgwITsjEM',
      price_id: 'price_1LEAouEsynfDvne4gU7UuIfw',
      user: user
    }
  end

  let(:invalid_plan_params) do
    {
      name: '',
      monthly_fee: 20,
      product_id: 'prod_Lw2uONgwITsjEM',
      price_id: 'price_1LEAouEsynfDvne4gU7UuIfw',
      user: user
    }
  end

  let(:price_params) do
    {
      unit_amount: 20,
      currency: 'usd',
      recurring: { interval: 'month' },
      product: plan.product_id
    }
  end

  before do
    sign_in user
  end

  describe '#GET /index' do
    it 'render successful response' do
      get plans_url
      expect(response).to be_successful
    end
  end

  describe '#GET /new' do
    it 'render successful response' do
      get new_plan_url

      expect(response).to be_successful
      expect(response).to have_http_status(:success)
    end
  end

  describe '#GET /create' do
    context 'if valid parameters provided' do
      it 'project created successfully' do
        expect do
          post plans_url, params: { plan: valid_plan_params }
        end.to change(Plan, :count).by(1)

        plan = Plan.last

        expect(plan.name).to eq('Valid Plan')
        expect(plan.monthly_fee).to eq(20)
      end

      it 'redirect successful response' do
        post plans_url, params: { plan: valid_plan_params }
        expect(response).to redirect_to(plans_url)
      end
    end

    context 'if invalid paramters provided' do
      it 'plan not created successfully' do
        post plans_url, params: { plan: invalid_plan_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#GET /edit' do
    context 'for successful response' do
      it 'render successful response' do
        get edit_plan_url(plan)
        expect(response).to be_successful
      end
    end

    context 'for invalid params id' do
      it 'passing invalid plan id to get not_found response' do
        get edit_plan_url(300_000)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#PATCH /update' do
    let(:valid_update_attr) do
      {
        name: 'plan updated',
        monthly_fee: 100
      }
    end

    let(:invalid_update_attr) do
      {
        name: ''
      }
    end

    context 'for valid plans params' do
      it 'plan updated successfully' do
        patch plan_url(plan), params: { plan: valid_update_attr }
        plan.reload

        expect(plan.name).to eq('plan updated')
      end

      it 'plan updated successfully and redirect to plans path' do
        patch plan_url(plan), params: { plan: valid_update_attr }
        expect(response).to redirect_to(plans_url)
      end
    end

    context 'for invalid params' do
      it 'plan not updated successfully' do
        patch plan_url(plan), params: { plan: invalid_update_attr }
        plan.reload

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'passing invalid plan id to get not_found response' do
        get edit_plan_url(300_000)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#DELETE /destroy' do
    context 'if plan present' do
      it 'destroy plan susccessfully' do
        expect { delete plan_url(plan) }.to change(Plan, :count).by(-1)
      end

      it 'destroy plan and redirect to plans path successfully' do
        delete plan_url(plan)

        expect(response).to redirect_to(plans_url)
      end
    end

    context 'if plan with the given id not present' do
      it 'passing invalid plan id to get not_found response' do
        get edit_plan_url(300_000)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#stripe tests' do
    context 'test stripe product create' do
      it 'create stripe product successfully' do
        product = Stripe::Product.create({ name: 'plan.name' })
        expect(product.name).to eq('plan.name')
      end
    end

    context 'test stripe price create' do
      it 'create stripe price successfully' do
        price = Stripe::Price.create(price_params)
        expect(price.unit_amount).to eq(20)
      end
    end
  end
end
