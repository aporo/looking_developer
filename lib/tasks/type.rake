desc "Import Type Data"
namespace 'data' do
  task :type_import => :environment do
    data = YAML.load("#{Rails.root}/tmp/type.yml")
    data.each do |d|
      Type.create(:name => "", :pattern => "")
    end  
  end
end
