desc "Import User Data"
namespace 'data' do
  task :user_import => :environment do
    User.import
  end
end
