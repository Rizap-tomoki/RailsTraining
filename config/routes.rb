Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :departments
  resources :users do
    resources :departments
  end
  root "users#index"
  # Defines the root path route ("/")
end
