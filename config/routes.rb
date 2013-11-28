Ocrails::Application.routes.draw do
  get "blog/index"
  get "info/blog"
  get "info/faq"
  get "info/contact"
  get "info/about"
  get "home/index"

  # Home Page
  root 'home#index'

  #Info pages
  get '/about' => 'info#about'
  get '/contact' => 'info#contact'
  get '/faq' => 'info#faq'

  # Blog
  get '/blog' => 'blog#index'

  # Authorization

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get '/sign_out', to: 'sessions#destroy', as: 'sign_out'
  get '/sign_in', to: 'sessions#new', as: 'sign_in'
  get '/auth/failure', to: 'sessions#failure'
  resources :identities, only: [:new]
  resources :password_resets
end
