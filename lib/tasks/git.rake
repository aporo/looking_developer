desc "Git Repository Data Clear"
namespace 'git' do
  task :reflesh => :environment do
    CommitLog.delete_all
  end
end

desc "Import Git Repository Data"
namespace 'git' do
  task :import => :environment do
    CommitLog.import_repository_data
  end
end
