class UsersController < ApplicationController
#  before_filter :login_check, :only => ["edit","update","destroy"]
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      if smartphone?
        format.html {render :template => "users/index_smp"}
      else
        format.html # index.html.erb
        format.json { render :json => @users }
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      if smartphone?
        format.html {render :template => "users/show_smp"}
      else
        format.html # show.html.erb
        format.json { render :json => @user }
      end
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      if smartphone?
        format.html {render :template => "users/new_smp"}
      else
        format.html # new.html.erb
        format.json { render :json => @user }
      end
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    if smartphone?
      respond_to do |format|
        format.html {render :template => "users/edit_smp"}
      end
    end
  end

  # GET /users/login
  def login
    redirect_to(:controller => "users", :action => "show", :id => session[:user_id]) if logged_in? and return
    user = params[:user]
    if !user.nil? and User.auth?(user)
      user = User.find_by_name(user[:name])
      session[:user_id] = user.id
      redirect_to(:controller => "users", :action => "show", :id => session[:user_id]) if logged_in? and return
    end
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    delete_looking_types = @user.looking_types.select{|type| params[:looking_types].include?("#{type.id}") == false }
    respond_to do |format|
      if @user.update_attributes(params[:user]) and
          delete_looking_types.all?{|looking| LookingType.destroy([looking])}
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
