Rails.application.routes.draw do
  
  #devise_for :users
  
  namespace 'api' do
    namespace 'v1' do
      resources :users
      resources :projects
      resources :candidates
      resources :sessions, only: [:create, :destroy]
    end
  end
end
