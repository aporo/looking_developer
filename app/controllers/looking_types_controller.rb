class LookingTypesController < ApplicationController
  # GET /looking_types
  # GET /looking_types.json
  def index
    @looking_types = LookingType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @looking_types }
    end
  end

  # GET /looking_types/1
  # GET /looking_types/1.json
  def show
    @looking_type = LookingType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @looking_type }
    end
  end

  # GET /looking_types/new
  # GET /looking_types/new.json
  def new
    @looking_type = LookingType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @looking_type }
    end
  end

  # GET /looking_types/1/edit
  def edit
    @looking_type = LookingType.find(params[:id])
  end

  # POST /looking_types
  # POST /looking_types.json
  def create
    @looking_type = LookingType.new(params[:looking_type])

    respond_to do |format|
      if @looking_type.save
        format.html { redirect_to @looking_type, :notice => 'Looking type was successfully created.' }
        format.json { render :json => @looking_type, :status => :created, :location => @looking_type }
      else
        format.html { render :action => "new" }
        format.json { render :json => @looking_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /looking_types/1
  # PUT /looking_types/1.json
  def update
    @looking_type = LookingType.find(params[:id])

    respond_to do |format|
      if @looking_type.update_attributes(params[:looking_type])
        format.html { redirect_to @looking_type, :notice => 'Looking type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @looking_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /looking_types/1
  # DELETE /looking_types/1.json
  def destroy
    @looking_type = LookingType.find(params[:id])
    @looking_type.destroy

    respond_to do |format|
      format.html { redirect_to looking_types_url }
      format.json { head :ok }
    end
  end
end
