Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  get    'logout'   => 'sessions#new'
  delete 'logout'  => 'sessions#destroy'
  namespace :admin do
    resources :departments
    resources :skills
    resources :users do
      resources :departments
      resources :skills
        member do
          get :img
        end
    end
  end
  resources :users, only: [:index, :show]
  root "users#index"
  # Defines the root path route ("/")
end
