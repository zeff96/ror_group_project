Rails.application.routes.draw do
  get 'home/index'
  devise_for :users

  devise_scope :user do
    authenticated :user do
      #root to: "devise/sessions#new", as: :authenticated_root
    end

    unauthenticated :user do
      root to: "devise/sessions#new", as: :authenticated_root
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
