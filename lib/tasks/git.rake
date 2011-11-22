desc "Refesh Git Repository Data"
namespace 'git' do
  task :reflesh => :environment do
    User.delete_all
    CommitLog.delete_all
  end
end

desc "Import Git Repository Data"
namespace 'git' do
  task :import => :environment do
    Repository.all.each do |repo|
      repo.import
    end
  end
end
