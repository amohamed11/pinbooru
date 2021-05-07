require 'sidekiq/web'

Rails.application.routes.draw do
  resources :posts do
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
    member do
      delete :delete_image
    end
  end

  devise_for :users
  root to: 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
