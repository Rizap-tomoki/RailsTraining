Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :departments
  resources :skills
  resources :users do
    resources :departments
    resources :skills
    resources :user_skills
  end
  root "users#index"
  # Defines the root path route ("/")
end
