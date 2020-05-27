Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Devise
  devise_for :users, skip: %i[registrations], controllers: { sessions: 'sessions' }
  devise_scope :user do
    root to: 'dashboard#index'
  end
  
  # Dashboard
  get 'dashboard', to: 'dashboard#index'
  
  # MEMBERS
  get 'account/edit', to: 'members#edit'
  put 'account/edit_password', to: 'members#edit_password'
  get 'account/register', to: 'members#register'
  get '/convite/:username', to: 'members#register'
  patch 'member_change_password', to: 'members#member_change_password'
  resources :members, except: [:index]
  
  # USERS
  resources :users, only: [:index, :show, :edit, :update]
  
  # Cities
  get 'get_cities', to: 'cities#get_cities_by_state'
  get 'get_cities_by_name', to: 'cities#get_by_name'
  get 'concat_cities', to: 'cities#concat'
  get 'list', to: 'cities#list'

  #Accounts
  resources :accounts

  #Incomes
  resources :incomes, only: [:new, :create]
  
end
