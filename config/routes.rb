Mysenso::Application.routes.draw do
  resource :user do
    resource :avatar do
      collection do
        get 'index'
        put 'update_crop'
      end
    end
  end

  resources :avatars

  resources :photos do
    collection do
      get 'manage'
    end
  end

  devise_for :user, :path_prefix => 'd'
  match '/users/:id' => 'users#show', :as => 'user', :via => :get
  match '/users/:id' => 'users#update', :as => 'user', :via => :put

  root :to => "home#index"
  
end
