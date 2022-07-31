# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    authenticated :user do
      root 'admin/plans#index', as: :authenticated_root
      scope module: 'admin' do
        resources :users, path: 'buyers' do
          member do
            patch :resend_invitation
          end
        end
        resources :plans, except: :show do
          resources :features
        end
      end
    end
  end

  resources :billings, only: :create
  resources :checkouts, only: %i[create success]

  resources :feature_usages, only: :create
  resources :subscriptions, only: :index
  resources :webhooks, only: :create
  get 'success', to: 'checkouts#success'
  root to: 'welcome_page#index'
end
