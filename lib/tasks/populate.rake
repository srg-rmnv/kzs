# coding: utf-8

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    User.destroy_all
    
    User.populate 15 do |user|
      user.name = Faker::Name.name
      user.phone = '7590176'
      user.position = Faker::Lorem.words(1)
      user.division = Faker::Lorem.words(1)
      user.info = Populator.sentences(1..3)
      user.dob = rand(20.years).ago
      user.permit = rand(768..999)
      user.work_status = ['at_work', 'ooo'].sample
      user.organization_id = rand(1..3)
      user.email = Faker::Internet.free_email
      user.encrypted_password = User.new(:password => "password").encrypted_password
    end
    
    User.create!(:name => 'Tester', :phone => '7777777', :position => 'Tester', :division => 'НТР', :info => 'НЕТ', :dob => 1998, :permit => '777', :work_status => 'at_work', :organization_id => '2', :email => 'babrovka@gmail.com', :password => 'password', :password_confirmation => 'password')

    
    User.all.each { |user| user.avatar = File.open(Dir.glob(File.join(Rails.root, 'avatars', '*')).sample); user.save! }

  end
end

