class MilksController < ApplicationController
  def index
    @milks = Milk.all

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

    @milk.user_id = params.fetch("user_id")
    @milk.date_milk_expires = params.fetch("date_milk_expires")
    @milk.description = params.fetch("description")

    if @milk.valid?
      @milk.save

      redirect_to("/milks/#{@milk.id}", :notice => "Milk updated successfully.")
    else
      render("milk_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row
    @milk = Milk.find(params.fetch("id_to_remove"))

    @milk.destroy

    redirect_to("/milks", :notice => "Milk deleted successfully.")
  end
end