Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  get 'welcome/index'
  root 'welcome#index'

  resources :courses do
    member do
      get 'duplicate'
    end
  end

  resources :letters do
    member do
      get 'duplicate'
    end
  end

  resources :items

  resources :iucat_records
end
