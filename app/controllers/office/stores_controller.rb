class Office::StoresController < ApplicationController

  set_tab :store_show, :subnav, :only => :show
  set_tab :store_edit, :subnav, :only => [:edit, :update]

  def show
    @store = Store.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @store }
    end
  end


  # GET /stores/1/edit
  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to(@store, :notice => 'Store was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @store = Store.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(stores_url) }
      format.xml  { head :ok }
    end
  end
end
