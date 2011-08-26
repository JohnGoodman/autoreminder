class PetsController < ApplicationController
  before_filter :authenticate_person!
  before_filter :get_person

  set_tab :pet_new, :subnav, :only => :new

  def index
    @pets = @store.pets.all
  end

  def new
    @pet = @person.pets.new
  end

  def edit
    @pet = Pet.find(params[:id])
    @default_email = @pet.email
  end

  def create
    @pet = @person.pets.new(params[:pet])

    respond_to do |format|
      if @pet.save
        format.html { redirect_to(store_person_path(@store, @person), :notice => 'Pet was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @pet = Pet.find(params[:id])

    respond_to do |format|
      if @pet.update_attributes(params[:pet])
        format.html { redirect_to(store_person_path(@store, @person), :notice => 'Pet was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @pet = Pet.find(params[:id]).destroy
    redirect_to(pets_url)
  end

  def get_person
    params[:person_id] ? @person = Person.find(params[:person_id]) : @person = Person.find(Pet.find(params[:id]).person_id)
  end
end
