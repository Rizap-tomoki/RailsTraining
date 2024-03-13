Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get    'login'   => 'logins#new'
  post   'login'   => 'logins#create'
  get    'logout'   => 'logins#new'
  delete 'logout'  => 'logins#destroy'
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
