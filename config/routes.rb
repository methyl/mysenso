Mysenso::Application.routes.draw do
  get "home/index"
  
  match "profile/edit" => "users#edit"
  match "users/edit" => "users#edit"
  
  devise_for :users
  
  

  root :to => "home#index"
  
end
