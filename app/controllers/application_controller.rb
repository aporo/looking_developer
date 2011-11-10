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

end
