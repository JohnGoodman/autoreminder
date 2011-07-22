class PeopleController < ApplicationController
  before_filter :authenticate_person!

  set_tab :person_show, :subnav, :only => :show
  set_tab :person_new, :subnav, :only => :new
  set_tab :person_edit, :subnav, :only => [:edit, :update]

  def index
    @people = @store.customers

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end

  def new
    @person = @store.people.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  def edit
    @person = Person.find(params[:id])
  end

  def create
    @person = @store.people.new(params[:person])
    @person.role = Role.find(4) unless params[:person][:role]

    respond_to do |format|
      if @person.save
        format.html { redirect_to(store_person_path(@store, @person), :notice => 'Person was successfully created.') }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(person_path(@person), :notice => 'Person was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @person = Person.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(store_people_path(@store)) }
      format.xml  { head :ok }
    end
  end
end
