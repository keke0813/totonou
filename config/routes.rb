Rails.application.routes.draw do
  # 管理者側のルーティング設定
  # URL /admin/sign_in ...
  devise_for :admin,skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :post_saunas, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
    get "tagsearches/search" => "tagsearches#search"
    get "searches/search" => "searches#search"
    patch "admin/users/information/:id" => "users#update", as: 'users_information_update'
    resources :users, only: [:index, :show, :edit] do
      member do
        get :liked_post_saunas
      end
      get "followings" => "relationships#followings", as: 'followings'
      get "followers" => "relationships#followers", as: 'followers'
    end
  end


  # 顧客側のルーティング設定
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: 'public' do
    root to: "homes#top"
    get "about" => "homes#about"
    patch "post_saunas/:id" => "post_saunas#update", as: 'post_saunas_update'
    resources :post_saunas, only: [:index, :create, :new, :edit, :show, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    get "tagsearches/search" => "tagsearches#search"
    get "searches/search" => "searches#search"
    get "users/information/edit/:id" => "users#edit", as: 'users_information_edit'
    patch "users/information/:id" => "users#update", as: 'users_information_update'
    resources :users, only: [:index, :show] do
      member do
        get :liked_post_saunas
      end
      resource :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: 'followings'
        get "followers" => "relationships#followers", as: 'followers'
    end
  end

  # ゲストユーザーのルーティング設定
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end