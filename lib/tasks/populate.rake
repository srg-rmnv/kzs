# coding: utf-8

require 'csv'
require 'faker'

namespace :csv do
  desc "Import permissions"
  task :import_permissions => :environment do
    
    Permission.destroy_all
    
    Permission.reset_pk_sequence
    
    csv_file_path = 'db/permissions.csv'

    CSV.foreach(csv_file_path) do |row|
      row = Permission.create!({
        :id => row[0],
        :title => row[1],
        :description => row[2],        
      })
      puts "Permission imported!"
    end
    
    
  end
end

namespace :users do
  task :create => :environment do
    
    
    
    User.create!(:last_name => 'demo', :username => 'demon', :first_name => 'demon', :middle_name => 'demo', :phone => '7777777', :position => 'babrovka', :division => 'НТР', :info => 'НЕТ', :dob => 1998, :organization_id => '3', :work_status => 'at_work', :organization_id => '2', :email => 'babrovka@gmail.com', :password => '111', :password_confirmation => '111')
    
    puts "Users create!"
    
  end
end

namespace :users do
  task :add_phones => :environment do
    
    User.all.each do |user|
      user.phone = nil
      user.phone = '88123361' + rand(100..999).to_s
    end
    
    puts "Phones added!"
    
  end
end


