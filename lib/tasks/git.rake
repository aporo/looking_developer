desc "Git Repository Data Clear"
namespace 'git' do
  task :reflesh => :environment do
    CommitLog.delete_all
  end
end

desc "Import Git Repository Data"
namespace 'git' do
  task :import => :environment do
    users = User.all
    repos = Repository.all
    repos.each do |repo|
      `git clone #{repo.url} /tmp/repo`
      users.each do |user|
        commit_at = ""
        `cd /tmp/repo &&  git log --author #{user.name} --name-only > /tmp/#{user.name}_git_log.txt`
        open("/tmp/#{user.name}_git_log.txt").each do |line|
          if line.include?("Date")
          commit_at = line.gsub("Date:   ","")
          end
        types = Type.all
          types.each do |type|
            if line.include?(type.pattern)
              CommitLog.create(:commit_at => commit_at,:user_id => user.id, :type_id => type.id)
            end
        end
        end
        `rm "/tmp/#{user.name}_git_log.txt"`
      end
      `rm -rf /tmp/repo`
    end
  end
end
