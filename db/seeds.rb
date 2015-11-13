# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(first:  "Example",
             last: "User", 
             address: "Example Address",
             url: "example.com", 
             email: "example@foobar.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     false,
             activated: true,
             activated_at: Time.zone.now,
             publisher: false)
             
User.create!(first:  "Example",
             last: "Publisher", 
             address: "Example Address",
             url: "example.com", 
             email: "publisher@foobar.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     false,
             activated: true,
             activated_at: Time.zone.now,
             publisher: true)
             
User.create!(first:  "Example",
             last: "Admin", 
             address: "Example Address",
             url: "example.com", 
             email: "admin@foobar.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now,
             publisher: false)
             
Publisher.create!(company: "ACME Corporation",
                  position: "Bricklayer",
                  user_id: 2)