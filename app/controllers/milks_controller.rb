class MilksController < ApplicationController
  before_action :current_user_must_be_milk_user, :only => [:show, :edit_form, :update_row, :destroy_row]

  def current_user_must_be_milk_user
    milk = Milk.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_user == milk.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = current_user.milks.ransack(params[:q])
    @milks = @q.result(:distinct => true).includes(:user).page(params[:page]).per(10)

    render("milk_templates/index.html.erb")
  end

  def show
    @milk = Milk.find(params.fetch("id_to_display"))

    render("milk_templates/show.html.erb")
  end

  def new_form
    @milk = Milk.new

    render("milk_templates/new_form.html.erb")
  end

  def create_row
    @milk = Milk.new

    @milk.user_id = params.fetch("user_id")
    @milk.date_milk_expires = params.fetch("date_milk_expires")
    @milk.description = params.fetch("description")

    if @milk.valid?
      @milk.save

      redirect_back(:fallback_location => "/milks", :notice => "Milk created successfully.")
    else
      render("milk_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @milk = Milk.find(params.fetch("prefill_with_id"))

    render("milk_templates/edit_form.html.erb")
  end

  def update_row
    @milk = Milk.find(params.fetch("id_to_modify"))

    
    @milk.date_milk_expires = params.fetch("date_milk_expires")
    @milk.description = params.fetch("description")

    if @milk.valid?
      @milk.save

      redirect_to("/milks/#{@milk.id}", :notice => "Milk updated successfully.")
    else
      render("milk_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_user
    @milk = Milk.find(params.fetch("id_to_remove"))

    @milk.destroy

    redirect_to("/users/#{@milk.user_id}", notice: "Milk deleted successfully.")
  end

  def destroy_row
    @milk = Milk.find(params.fetch("id_to_remove"))

    @milk.destroy

    redirect_to("/milks", :notice => "Milk deleted successfully.")
  end
end
