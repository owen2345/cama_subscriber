Rails.application.routes.draw do

    scope PluginRoutes.system_info["relative_url_root"] do
      scope '(:locale)', locale: /#{PluginRoutes.all_locales}/, :defaults => {  } do
        # frontend
        namespace :plugins do
          namespace 'cama_subscriber' do
            post 'subscribe' => 'front#subscribe'
            get 'unsubscribe/:key' => 'front#unsubscribe', as: :unsubscribe
            get 'unsubscribe_all/:key' => 'front#unsubscribe_all', as: :unsubscribe_all
            get 'verify/:key' => 'front#verify', as: :verify
            get 'image_email/:key' => 'front#image_email', as: :image_email
          end
        end
      end

      #Admin Panel
      scope 'admin', as: 'admin' do
        namespace 'plugins' do
          namespace 'cama_subscriber' do
            resources :groups
            resources :promotions do
              get 'send_campaign'
              get 'send_test' => :form_test
              post 'send_test'
            end
            resources :items
            get 'settings' => 'admin#settings'
            post 'settings' => 'admin#save_settings'
          end
        end
      end

      # main routes
      #scope 'cama_subscriber', module: 'plugins/cama_subscriber/', as: 'cama_subscriber' do
      #  Here my routes for main routes
      #end
    end
  end
