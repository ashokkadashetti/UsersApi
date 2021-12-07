# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users
      resources :projects
      resources :candidates
      resources :sessions, only: %i[create destroy]
    end
  end
end
