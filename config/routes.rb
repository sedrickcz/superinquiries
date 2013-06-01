Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :superinquiries do
    resources :superinquiries, :path => '', :only => [:index, :show]
    resources :inboxes do 
      get :thank_you, on: :collection
    end
  end

  # Admin routes
  namespace :superinquiries, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :superinquiries, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

  get 'refinery/superinquiries/inbox/:id', to: 'superinquiries/admin/superinquiries#show_inbox', as: :superinquiries_admin_superinquiries_inbox
   delete 'refinery/superinquiries/inbox/:id', to: 'superinquiries/admin/superinquiries#delete_inbox', as: :superinquiries_admin_superinquiries_inbox
   get 'refinery/superinquiries/inbox/:id/check',  to: 'superinquiries/admin/superinquiries#change_state', as: :superinquiries_admin_superinquiries_inbox_check
   get 'refinery/superinquiries/inbox/:id/spam',  to: 'superinquiries/admin/superinquiries#change_spam', as: :superinquiries_admin_superinquiries_inbox_spam

end
