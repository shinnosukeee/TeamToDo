Rails.application.routes.draw do
  root to: "teams#index"

  devise_for :users

  resources :teams do
    member do
      post :join
      delete :leave
      get :invite
    end
    resources :tasks

    collection do
      get :join_form
      post :join_by_code
    end
  end
end