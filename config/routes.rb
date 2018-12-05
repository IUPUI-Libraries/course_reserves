Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  resources :courses
  get 'welcome/index'

  root 'welcome#index'

  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :iucat_records
  
end
