require 'open-uri'
require 'json'

class GitHubApi
  API_ROOT = "http://github.com/api/v2/json/"
  attr_accessor :user

  def initialize(name)
    open("#{API_ROOT}user/show/#{name}") {|f|
      if f.status.include?("OK")
        json = ""
        f.each_line {|line|
          json << line
        }
        @user = JSON.parse(json)
      else
        @user = nil
      end
    }
  end
  
  def contributors(repository)
    open("#{API_ROOT}repos/show/#{@user["user"]["login"]}/#{repository}/contributors") {|f|
      if f.status.include?("OK")
        json = ""
        f.each_line {|line|
          json << line
        }
        JSON.parse(json)
      else
        nil
      end
    }
  end
end
