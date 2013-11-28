StripeTest::Application.routes.draw do

  resources :users do
    resources :cards do
      resources :charges do
        post :refund
      end
    end
    resources :bank_accounts do
      resources :transfers  do
        post :cancel
      end
    end
  end

  # You can have the root of your site routed with "root"
  root 'users#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
#== Route Map
# Generated on 28 Nov 2013 12:33
#
#           user_card_charge_refund POST   /users/:user_id/cards/:card_id/charges/:charge_id/refund(.:format)                     charges#refund
#                 user_card_charges GET    /users/:user_id/cards/:card_id/charges(.:format)                                       charges#index
#                                   POST   /users/:user_id/cards/:card_id/charges(.:format)                                       charges#create
#              new_user_card_charge GET    /users/:user_id/cards/:card_id/charges/new(.:format)                                   charges#new
#             edit_user_card_charge GET    /users/:user_id/cards/:card_id/charges/:id/edit(.:format)                              charges#edit
#                  user_card_charge GET    /users/:user_id/cards/:card_id/charges/:id(.:format)                                   charges#show
#                                   PATCH  /users/:user_id/cards/:card_id/charges/:id(.:format)                                   charges#update
#                                   PUT    /users/:user_id/cards/:card_id/charges/:id(.:format)                                   charges#update
#                                   DELETE /users/:user_id/cards/:card_id/charges/:id(.:format)                                   charges#destroy
#                        user_cards GET    /users/:user_id/cards(.:format)                                                        cards#index
#                                   POST   /users/:user_id/cards(.:format)                                                        cards#create
#                     new_user_card GET    /users/:user_id/cards/new(.:format)                                                    cards#new
#                    edit_user_card GET    /users/:user_id/cards/:id/edit(.:format)                                               cards#edit
#                         user_card GET    /users/:user_id/cards/:id(.:format)                                                    cards#show
#                                   PATCH  /users/:user_id/cards/:id(.:format)                                                    cards#update
#                                   PUT    /users/:user_id/cards/:id(.:format)                                                    cards#update
#                                   DELETE /users/:user_id/cards/:id(.:format)                                                    cards#destroy
# user_bank_account_transfer_cancel POST   /users/:user_id/bank_accounts/:bank_account_id/transfers/:transfer_id/cancel(.:format) transfers#cancel
#       user_bank_account_transfers GET    /users/:user_id/bank_accounts/:bank_account_id/transfers(.:format)                     transfers#index
#                                   POST   /users/:user_id/bank_accounts/:bank_account_id/transfers(.:format)                     transfers#create
#    new_user_bank_account_transfer GET    /users/:user_id/bank_accounts/:bank_account_id/transfers/new(.:format)                 transfers#new
#   edit_user_bank_account_transfer GET    /users/:user_id/bank_accounts/:bank_account_id/transfers/:id/edit(.:format)            transfers#edit
#        user_bank_account_transfer GET    /users/:user_id/bank_accounts/:bank_account_id/transfers/:id(.:format)                 transfers#show
#                                   PATCH  /users/:user_id/bank_accounts/:bank_account_id/transfers/:id(.:format)                 transfers#update
#                                   PUT    /users/:user_id/bank_accounts/:bank_account_id/transfers/:id(.:format)                 transfers#update
#                                   DELETE /users/:user_id/bank_accounts/:bank_account_id/transfers/:id(.:format)                 transfers#destroy
#                user_bank_accounts GET    /users/:user_id/bank_accounts(.:format)                                                bank_accounts#index
#                                   POST   /users/:user_id/bank_accounts(.:format)                                                bank_accounts#create
#             new_user_bank_account GET    /users/:user_id/bank_accounts/new(.:format)                                            bank_accounts#new
#            edit_user_bank_account GET    /users/:user_id/bank_accounts/:id/edit(.:format)                                       bank_accounts#edit
#                 user_bank_account GET    /users/:user_id/bank_accounts/:id(.:format)                                            bank_accounts#show
#                                   PATCH  /users/:user_id/bank_accounts/:id(.:format)                                            bank_accounts#update
#                                   PUT    /users/:user_id/bank_accounts/:id(.:format)                                            bank_accounts#update
#                                   DELETE /users/:user_id/bank_accounts/:id(.:format)                                            bank_accounts#destroy
#                             users GET    /users(.:format)                                                                       users#index
#                                   POST   /users(.:format)                                                                       users#create
#                          new_user GET    /users/new(.:format)                                                                   users#new
#                         edit_user GET    /users/:id/edit(.:format)                                                              users#edit
#                              user GET    /users/:id(.:format)                                                                   users#show
#                                   PATCH  /users/:id(.:format)                                                                   users#update
#                                   PUT    /users/:id(.:format)                                                                   users#update
#                                   DELETE /users/:id(.:format)                                                                   users#destroy
