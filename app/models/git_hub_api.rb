require 'open-uri'

class GitHubApi
  def initialize(name)
    json_data= open("http://github.com/api/v2/json/user/show/#{name}")
    @user = JSON.load(json_data) and return
  end
end
