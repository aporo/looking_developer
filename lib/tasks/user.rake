desc "Import User Data"
namespace 'data' do
  task :user_import => :environment do
    Repository.all.each do |repo|
      repo_info = repo.url.split('/')
      project = repo_info.pop
      login = repo_info.pop
      github = GitHubApi.new(login)
      unless github.nil?
        contributors = github.contributors(project.gsub('.git',''))
        unless contributors.nil?
          contributors["contributors"].each do |contributor|
            User.create({
                          :name => contributor["login"],
                          :email => contributor["email"],
                          :image => "http://0.gravatar.com/avatar/#{contributor["gravatar_id"]}"
                        })
          end
        end
      end
    end
  end
end
