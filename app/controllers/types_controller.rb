class TypesController < ApplicationController
  before_filter :authenticate, :except => ["rank","show"]
  # GET /types
  # GET /types.json
  def index
    @types = Type.all.sort{|a,b| a.name <=> b.name }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @types }
    end
  end

  def rank
    @types = Type.rank
    respond_to do |format|
      if smartphone?
        format.html { render :template => "types/rank_smp"}
      else
        format.html # rank.html.erb
        format.json { render :json => @types }
      end
    end
  end

  # GET /types/1
  # GET /types/1.json
  def show
    @type = Type.find(params[:id])

    respond_to do |format|
      if smartphone?
        format.html { render :template => "types/show_smp"}
      else
        format.html # show.html.erb
        format.json { render :json => @type }
      end
    end
  end

  # GET /types/new
  # GET /types/new.json
  def new
    @type = Type.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @type }
    end
  end

  # GET /types/1/edit
  def edit
    @type = Type.find(params[:id])
  end

  # POST /types
  # POST /types.json
  def create
    @type = Type.new(params[:type])

    respond_to do |format|
      if @type.save
        format.html { redirect_to @type, :notice => 'Type was successfully created.' }
        format.json { render :json => @type, :status => :created, :location => @type }
      else
        format.html { render :action => "new" }
        format.json { render :json => @type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /types/1
  # PUT /types/1.json
  def update
    @type = Type.find(params[:id])

    respond_to do |format|
      if @type.update_attributes(params[:type])
        format.html { redirect_to @type, :notice => 'Type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /types/1
  # DELETE /types/1.json
  def destroy
    @type = Type.find(params[:id])
    @type.destroy

    respond_to do |format|
      format.html { redirect_to types_url }
      format.json { head :ok }
    end
  end
end
