Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      post 'users' => 'users#create'
      patch 'users' => 'users#update'
    end
  end
  
end
