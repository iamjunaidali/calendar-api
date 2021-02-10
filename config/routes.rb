require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/jobs'
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [Rails.env, (ENV['sidekiq_web_pass'] || 'hello#admin')]
  end

  namespace :api do
    namespace :v1 do
      resources :events, only: [:index, :create, :update, :destroy] do
        collection do
          get :search_events
        end
      end
    end
  end
end
