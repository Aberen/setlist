Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users

  resources :bands do
    resources :memberships,  only: [:index, :destroy]
    resources :invitations,  only: [:new, :create]
    resources :songs
    resources :setlists,     only: [:index, :new, :create, :destroy]
  end

  resources :setlists, only: [:show, :edit, :update] do
    resources :setlist_items,      only: [:create, :update, :destroy]
    resources :setlist_song_notes, only: [:create, :update]
  end

  # Top-level cross-band indexes
  get '/songs',    to: 'songs#all',    as: :all_songs
  get '/setlists', to: 'setlists#all', as: :all_setlists

  get '/invitations/:token/accept', to: 'invitations#accept', as: :accept_invitation

  root to: 'home#index'

  get "manifest"      => "rails/pwa#manifest",       as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
