Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  get 'search', to: 'stock#search'
  get 'portfolio', to: 'users#portfolio'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'sign_up', to: 'devise/registrations#new'
    post 'sign_up', to: 'devise/registrations#create'
    get 'sign_in', to: 'devise/sessions#new'
    post 'sign_in', to: 'devise/sessions#create'
    get 'sign_out', to: 'devise/sessions#destroy', as: :sign_out
    delete 'sign_out', to: 'devise/sessions#destroy'
    get 'profile/edit', to: 'devise/registrations#edit'

  end
  root 'home#index'
  get 'home/index'
  get 'pricing', to: 'home#pricing'
  get 'friends', to: 'home#friends'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
