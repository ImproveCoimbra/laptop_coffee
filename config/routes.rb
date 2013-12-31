LaptopCoffee::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get ':action', :controller => 'front'
  root :to => "front#index"
end
