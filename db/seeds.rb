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
             
User.create!(first:  "Bessie",
             last: "Vila", 
             address: "4216 Gorby Lane, Jackson, MS 39201",
             url: "LogTrades.com", 
             email: "userBV@foobar.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     false,
             activated: true,
             activated_at: Time.zone.now,
             publisher: false)

User.create!(first:  "Eva",
             last: "Walker", 
             address: "1705 Hidden Pond Road, Nashville, TN 37201",
             url: "SinglesAgent.com", 
             email: "userEW@foobar.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     false,
             activated: true,
             activated_at: Time.zone.now,
             publisher: false)
             
User.create!(first:  "Alexander",
             last: "Garren", 
             address: "4584 Griffin Street, Phoenix, AZ 85012",
             url: "TheyTell.com", 
             email: "userAG@foobar.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     false,
             activated: true,
             activated_at: Time.zone.now,
             publisher: false)

User.create!(first:  "Dennis",
             last: "Samons", 
             address: "2441 Michael Street, Houston, TX 77006",
             url: "ConfidentialJournal.com", 
             email: "publisherDS@foobar.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     false,
             activated: true,
             activated_at: Time.zone.now,
             publisher: true)
             
Publisher.create!(company: "ACME Corporation",
                  position: "Bricklayer",
                  user_id: 2)

Publisher.create!(company: "Anderson-Little",
                  position: "Shipping clerk",
                  user_id: 7)
                
Link.create!(url: "http://www.google.com/",
             publisher_id: 1,
             used: false,
             cpm: 4.0,
             title: "Google", 
             category: "Search Engine", 
             date: 2.days.ago)
             
Generatedlink.create!(url: 'http://goo.gl/Vrt8VD',
                    paidout: false,
                    user_id: 1,
                    link_id: 1,
                    date: 8.hours.ago)
                    
 
 
 
#http://goo.gl/6DdMJJ
#http://goo.gl/Whs2up
