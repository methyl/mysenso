# -*- encoding : utf-8 -*-
Mysenso::Application.routes.draw do
  resource :user do
    resource :avatar do
      collection do
        get 'index'
        put 'update_crop'
      end
    end
  end

  resources :references, :only => [:destroy] do
    collection do
      get 'index'
    end
    member do
      put 'accept'
    end
  end

  resources :private_messages, :except => [:edit, :update] do
 
    collection do
      get 'received' => 'private_messages#index'
      get 'sent' => 'private_messages#index', :defaults => { :type => :sent }
      post 'destroy_multiple'
      post 'mark_as_read_multiple'
    end
    
  end

  resources :avatars

  resources :photos do
    collection do
      get 'manage'
    end
  end

  devise_for :user, :path_prefix => 'd' do
    root :to => "home#index"
  end

  resources :users, :except => [:update, :show] do
    collection do
      get 'search'
      get 'search_companies'
      post 'index'
    end
    resource :private_message, :only => [:new]
    resources :references, :only => [:new, :create]
  end
  get '/users/:id' => 'users#show', :as => 'user'
  put '/users/:id' => 'users#update', :as => 'user'

  root :to => "home#index"

end
