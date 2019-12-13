Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "milks#index"
  # Routes for the Milk resource:

  # CREATE
  get("/milks/new", { :controller => "milks", :action => "new_form" })
  post("/create_milk", { :controller => "milks", :action => "create_row" })

  # READ
  get("/milks", { :controller => "milks", :action => "index" })
  get("/milks/:id_to_display", { :controller => "milks", :action => "show" })

  # UPDATE
  get("/milks/:prefill_with_id/edit", { :controller => "milks", :action => "edit_form" })
  post("/update_milk/:id_to_modify", { :controller => "milks", :action => "update_row" })

  # DELETE
  get("/delete_milk/:id_to_remove", { :controller => "milks", :action => "destroy_row" })
  get("/delete_milk_from_user/:id_to_remove", { :controller => "milks", :action => "destroy_row_from_user" })

  #------------------------------

  devise_for :users
  # Routes for the User resource:

  # READ
  get("/users", { :controller => "users", :action => "index" })
  get("/users/:id_to_display", { :controller => "users", :action => "show" })

  #------------------------------

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
