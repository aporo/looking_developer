task :git_import => :environment do
  ENV['RAILS_ROOT'] = '/Users/m-kondo/rails/looking_developer'
  users = User.all
  repos = Repository.all
  users.each do |user|
    commit_at = ""
    repos.each do |repo|
      `git clone #{repo.url} #{ENV['RAILS_ROOT']}/#{user.name}`
      `cd "#{ENV['RAILS_ROOT']}/#{user.name}"| git log --author "#{user.name}" --name-only > "#{ENV['RAILS_ROOT']}/tmp/#{user.name}_git_log.txt"`
      open("#{ENV['RAILS_ROOT']}/tmp/#{user.name}_git_log.txt").each do |line|
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
     `rm "#{ENV['RAILS_ROOT']}/tmp/#{user.name}_git_log.txt"`
     `rm -rf "#{ENV['RAILS_ROOT']}/#{user.name}"`
    end
  end
end
