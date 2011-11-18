class CommitLog < ActiveRecord::Base
  validates_presence_of :commit_at,:user_id
  validates_uniqueness_of :commit_at, :scope => [:user_id,:type_id]
  belongs_to :user
  belongs_to :type

  def self.import_repository_data
    users = User.all
    repos = Repository.all
    types = Type.all
    types_count = {}
    repos.each do |repo|
      if Rails.env == "production"
        tmp_path = "#{Rails.root}/public"
      else
        tmp_path = "#{Rails.root}/tmp"
      end
      repo_path = "#{tmp_path}/repo"
      if Dir.exist?(repo_path)
        `rm -rf #{repo_path}`
      end
      
      `git clone #{repo.url} #{repo_path}`
      users.each do |user|
        types.each do |type|
          types_count[type.name] = 0
        end
        commit_at = ""
        `cd #{repo_path} && git log --author #{user.name} --name-only > #{tmp_path}/#{user.name}_git_log.txt`
        open("#{tmp_path}/#{user.name}_git_log.txt").each do |line|
          if line.include?("Date")
            commit_at = line.gsub("Date:   ","")
          end
          types.each do |type|
            if line.include?(type.pattern)
              types_count[type.name] += 1
            end
          end
        end
        types.each do |type|
          CommitLog.create(:commit_at => commit_at,:user_id => user.id, :type_id => type.id,:count => types_count[type.name])
        end
        `rm "#{tmp_path}/#{user.name}_git_log.txt"`
      end
      `rm -rf #{repo_path}`
    end
  end
end
