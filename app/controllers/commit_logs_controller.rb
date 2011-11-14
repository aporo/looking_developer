class CommitLogsController < ApplicationController
  before_filter :authenticate
  # GET /commit_logs
  # GET /commit_logs.json
  def index
    @commit_logs = CommitLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @commit_logs }
    end
  end

  # GET /commit_logs/1
  # GET /commit_logs/1.json
  def show
    @commit_log = CommitLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @commit_log }
    end
  end

  # GET /commit_logs/new
  # GET /commit_logs/new.json
  def new
    @commit_log = CommitLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @commit_log }
    end
  end

  # GET /commit_logs/1/edit
  def edit
    @commit_log = CommitLog.find(params[:id])
  end

  # POST /commit_logs
  # POST /commit_logs.json
  def create
    @commit_log = CommitLog.new(params[:commit_log])

    respond_to do |format|
      if @commit_log.save
        format.html { redirect_to @commit_log, :notice => 'Commit log was successfully created.' }
        format.json { render :json => @commit_log, :status => :created, :location => @commit_log }
      else
        format.html { render :action => "new" }
        format.json { render :json => @commit_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /commit_logs/1
  # PUT /commit_logs/1.json
  def update
    @commit_log = CommitLog.find(params[:id])

    respond_to do |format|
      if @commit_log.update_attributes(params[:commit_log])
        format.html { redirect_to @commit_log, :notice => 'Commit log was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @commit_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /commit_logs/1
  # DELETE /commit_logs/1.json
  def destroy
    @commit_log = CommitLog.find(params[:id])
    @commit_log.destroy

    respond_to do |format|
      format.html { redirect_to commit_logs_url }
      format.json { head :ok }
    end
  end
end
