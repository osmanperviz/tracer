Rails.application.routes.draw  do
 namespace :api,defaults:{format: 'json'}do
   resources :trace,except:[:new,:edit]
 end
end
