Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  scope '/admin' do
    resources :departments
    resources :skills
    resources :users do
      resources :departments
      resources :skills
    end
  end
  root "homes#index"
  # Defines the root path route ("/")
end
