require 'faker'

namespace :db do
  desc "File database with sample data"
  task :populate => :environment do
    make_admin
  end
end
    
def make_admin
	Rake::Task['db:reset'].invoke
	admin = User.create!(:name => "Yerong Chen",
	             :email => "jarricochen@gmail.com",
	             :password => "214177",
	             :password_confirmation => "214177")
	admin.toggle!(:admin)
	2.times do |n|
	  name = Faker::Name.name
	  email = "example-#{n+1}@foo.com"
	  password = "password"
	  User.create!(:name => name, 
	               :email => email, 
	               :password => password,
	               :password_confirmation => password)
	end
end

def make_microposts
	User.all(:limit => 3).each do |user|
	  50.times do
	    user.microposts.create!(:content => Faker::Lorem.sentence(5))
	  end
	end
end

def make_relationships
  users = User.all
  user = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end

