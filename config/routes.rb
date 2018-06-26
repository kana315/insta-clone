Rails.application.routes.draw do
  resources :posts do
    collection do
      post :confirm
      get :top
    end
  end

  resources :users, only: [:new, :create, :show, :edit, :update] do
    member do
      get :favorites
      get :posts
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]

  mount LetterOpenerWeb::Engine, at: "/inbox"
end
