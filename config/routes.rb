Articles::Application.routes.draw do
  root "articles#index"

  resources :categories, :comments
  resources :articles do
    collection do
      get "search"
      get "top10"
      get "neighbors"
    end
  end
end
