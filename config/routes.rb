Rails.application.routes.draw do
  devise_for :members
  mount Hyperloop::Engine => '/hyperloop'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'hyperloop#AppRouter'
  match '*all', to: 'hyperloop#AppRouter', via: [:get]
end
