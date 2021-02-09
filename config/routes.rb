Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
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
