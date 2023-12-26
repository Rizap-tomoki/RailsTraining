Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :departments
    resources :skills
    resources :users do
      resources :departments
      resources :skills
    end
  end
  resources :employees, only: [:index, :show]
  root "employees#index"
  # Defines the root path route ("/")
end
