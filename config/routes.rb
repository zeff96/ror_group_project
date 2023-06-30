Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root to: 'inventories#index', as: :authenticated_root
    end

    unauthenticated :user do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :recipes do
    resources :recipe_foods
  end

  resources :inventories do
    resources :inventory_foods
  end

  get 'shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
  
  resources :foods
  resources :public_recipes, only: %i[index]
end
