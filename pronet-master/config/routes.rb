# For routing documentation, please read http://edgeguides.rubyonrails.org/routing.html
# 
# Current Routing
#            Prefix Verb   URI Pattern                          Controller#Action
#              root GET    /                                    home#index
#          sessions POST   /sessions(.:format)                  sessions#create
#       new_session GET    /sessions/new(.:format)              sessions#new
#           session DELETE /sessions/:id(.:format)              sessions#destroy
#             flows GET    /flows(.:format)                     flows#index
#                   POST   /flows(.:format)                     flows#create
#          new_flow GET    /flows/new(.:format)                 flows#new
#         edit_flow GET    /flows/:id/edit(.:format)            flows#edit
#              flow GET    /flows/:id(.:format)                 flows#show
#                   PATCH  /flows/:id(.:format)                 flows#update
#                   PUT    /flows/:id(.:format)                 flows#update
#                   DELETE /flows/:id(.:format)                 flows#destroy
#      advance_flow POST   /flows/:id/advance/:status(.:format) flows#advance
#          metadata GET    /metadata(.:format)                  metadata#index
#             users GET    /users(.:format)                     users#index
#         edit_user GET    /users/:id/edit(.:format)            users#edit
#              user GET    /users/:id(.:format)                 users#show
#                   PATCH  /users/:id(.:format)                 users#update
#                   PUT    /users/:id(.:format)                 users#update
#    optical_alarms GET    /optical_alarms(.:format)            optical_alarms#index
#                   POST   /optical_alarms(.:format)            optical_alarms#create
# new_optical_alarm GET    /optical_alarms/new(.:format)        optical_alarms#new
#     optical_alarm GET    /optical_alarms/:id(.:format)        optical_alarms#show
#    topology_index GET    /topology(.:format)                  topology#index
#          topology GET    /topology/:id(.:format)              topology#show
#    authorize_host POST   /hosts/:id/authorize(.:format)       hosts#authorize
#  deauthorize_host POST   /hosts/:id/deauthorize(.:format)     hosts#deauthorize
#             hosts GET    /hosts(.:format)                     hosts#index
#              host GET    /hosts/:id(.:format)                 hosts#show
#                   PATCH  /hosts/:id(.:format)                 hosts#update
#                   PUT    /hosts/:id(.:format)                 hosts#update
Rails.application.routes.draw do
  root to: 'home#index'


  resources :sessions, only: [:create, :new, :destroy]
  resources :flows, only: [:index, :show, :new, :edit, :update, :create, :destroy]
  post "/flows/:id/advance/:status" => "flows#advance", as: :advance_flow

  resources :metadata, only: :index
  resources :users, only: [:show, :index, :edit, :update]
  resources :optical_alarms, only: [:index, :show, :new, :create]
  resources :topology, only: [:index, :show]
  # Host Links
  resources :hosts, only: [:index, :show, :update] do
    member do
      post :authorize
      post :deauthorize
    end
  end
end