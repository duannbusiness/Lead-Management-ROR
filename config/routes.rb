# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :user

  resources :leads do
    resources :phases
    resources :comments
    match 'status', via: %i[get post]
  end

  resources :phases, only: %i[] do
    resources :phase_users
    resources :requests
    resources :comments, controller: 'phase_comments'
    get 'accept/:id', to: 'phases#accept', as: 'accept'
    match 'reject/:id', to: 'phases#reject', via: %i[get post], as: 'reject'
    match 'status', via: %i[get post]
  end

  resources :users do
    resources :roles, controller: 'user_roles'
  end

  resources :roles
  resources :projects

  root 'home#index'

  namespace :api do
    namespace :v1 do
     resources :leads
    end
  end
end
