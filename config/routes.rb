Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Google認証によって追加
  get "auth/:provider/callback", to: "admin/sessions#google"
  get "auth/failure", to: redirect("/admin/session/new", status: :see_other)
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
  # Defines the root path route ("/")
end