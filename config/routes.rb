Rails.application.routes.draw do
  # Spree routes
  mount Spree::Core::Engine, at: '/store'

  # sidekiq web UI
  require 'sidekiq/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == Rails.application.secrets.sidekiq_username &&
      password == Rails.application.secrets.sidekiq_password
  end
  mount Sidekiq::Web, at: '/sidekiq'

  Rails.application.routes.draw do
  get 'home/index'
  if Rails.env.development?
      mount Lookbook::Engine, at: "/lookbook"
    end
  end

  root 'home#index'
end
