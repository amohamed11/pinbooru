require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :posts do
    member do
      delete :delete_image
    end
  end

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :show, :create, :destroy]
    end
  end

  devise_for :users
  root to: 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
