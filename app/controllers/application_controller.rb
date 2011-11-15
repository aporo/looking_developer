class ApplicationController < ActionController::Base
  protect_from_forgery
  def smartphone?
    if android? or iphone? or safari?
      @smartphone = true
    else
      @smartphone = false
    end
  end

  def safari?
    request.user_agent.include?("Safari")
  end

  def android?
    request.user_agent.include?("Android")
  end

  def iphone?
    request.user_agent.include?("iPhone")
  end

  def authenticate
    authenticate_or_request_with_http_basic do |name,password|
      (@name = name) == "voyage" and password == "voyage"
    end
  end

  def login_check
   unless logged_in?
     redirect_to(:controller => "users", :action => "index")
   end
  end

  def logged_in?
    !session[:user_id].nil?
  end
  
  def login(user_id)
    session[:user_id] = user_id
  end

  def logout
    session[:user_id] = nil
  end
end
