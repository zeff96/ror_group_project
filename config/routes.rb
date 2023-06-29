Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root to: "home#index", as: :authenticated_root
    end

    unauthenticated :user do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :recipes do
    resources :recipe_foods
  end

  resources :inventories

  get 'shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
end
