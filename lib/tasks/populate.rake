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
  desc "Import permissions"
  task :add_phones => :environment do
    
    User.all.each do |user|
      user.phone = nil
      user.phone = '88123361' + rand(100..999).to_s
    end
    
    puts "Phones added!"
    
  end
end


