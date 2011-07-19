Mysenso::Application.routes.draw do
  put '/profile/edit' => 'users#update'
  get '/profile/edit' => 'users#edit'
  get '/profile/:id' => 'users#show'
  get "/users/edit"
  
  devise_for :users
  
  

  root :to => "home#index"
  
end
