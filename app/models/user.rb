class User < ActiveRecord::Base
  validates_presence_of :name,:email
  validates_uniqueness_of :name
  has_many :commit_logs
  has_many :looking_types
  before_create :encode_pass
  after_destroy :destroy_relation

  def looking
    self.looking_types.map do |looking_type|
      unless looking_type.type.nil?
        looking_type.type.name
      end
    end
  end
  
  def not_looking
    Type.all.select do |type|
      self.looking_types.any?{ |looking_type| looking_type.type_id == type.id } == false
    end
  end
  
  def commit_count
    CommitLog.sum(:count,:conditions => {:user_id => self.id})
  end
  
  def commit_count_by_type
    Type.all.map do |type|
      {:name => type.name , :count => CommitLog.sum(:count,:conditions => {:user_id => self.id,:type_id => type.id})}
    end
  end
  
  def owner?(user_id)
    user_id == self.id
  end

  def has_twitter?
    !self.twitter.blank?
  end

  def self.auth?(user)
    u = User.find_by_name(user[:name])
    if !u.nil? and u.pass == u.encode(user[:pass])
      return true
    else
      return false
    end
  end
  
  def encode_pass
    self.pass = encode(self.pass)
  end

  def encode(pass)
    Digest::MD5.hexdigest("#{pass}looking")
  end

  def self.import_repository_data(repo)
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

  private
  def destroy_relation
    self.looking_types.each do |look_type|
      look_type.delete
    end
    self.commit_logs.each do |commit|
      commit.delete
    end
  end

end
