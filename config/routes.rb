Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "auth/:provider/callback", to: "admin/sessions#create"
  namespace :admin do
    resource :session, only: [:new, :destroy, :create]
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
  match '*path', to: 'application#render_404', via: :all
  # Defines the root path route ("/")
end