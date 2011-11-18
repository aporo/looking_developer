class CommitLog < ActiveRecord::Base
  validates_presence_of :commit_at,:user_id
  validates_uniqueness_of :commit_at, :scope => [:user_id,:type_id]
  belongs_to :user
  belongs_to :type

  def self.import_repository_data
    users = User.all
    repos = Repository.all
    repos.each do |repo|
      `git clone #{repo.url} #{Rails.root}/tmp/repo`
      users.each do |user|
        commit_at = ""
        `cd #{Rails.root}/tmp/repo && git log --author #{user.name} --name-only > #{Rails.root}/tmp/#{user.name}_git_log.txt`
        open("#{Rails.root}/tmp/#{user.name}_git_log.txt").each do |line|
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
        `rm "#{Rails.root}/tmp/#{user.name}_git_log.txt"`
      end
      `rm -rf #{Rails.root}/tmp/repo`
    end
  end
end
