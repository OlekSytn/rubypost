Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :members

  resources :members, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments
    end
  end

  root 'members#index'

  post 'api/v1/auth/login', to: 'authentication#login'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :members, only: %i[index show] do
        resources :posts, only: %i[index show] do
          resources :comments, only: %i[index show create]
          resources :likes, only: %i[create destroy]
        end
      end
    end
  end
end
