Rails.application.routes.draw do
  root to: 'site#home'
  get :contact, to: 'site#contact'
  resources :projects
end
