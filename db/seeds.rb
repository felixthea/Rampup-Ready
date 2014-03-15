# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# user1 = User.create(email: "notadmin@gmail.com", password: "password", subdivision_id: 1, admin: false)
# user2 = User.create(email: "admin@gmail.com", password: "password", subdivision_id: 1, admin: true)
# word1 = Word.create(name: "EOD")
# word2 = Word.create(name: "COB")
# word3 = Word.create(name: "Touch base")
# word4 = Word.create(name: "Synergy")
# subdivision1 = Subdivision.create(name: "Engineering")
# subdivision2 = Subdivision.create(name: "Finance")
# subdivision3 = Subdivision.create(name: "Operations")
# tag1 = Tag.create(name: "Financial Documents")
# tag2 = Tag.create(name: "Ruby Gems")
# tag3 = Tag.create(name: "Workflow terminology")
# tag4 = Tag.create(name: "General terms")
# def1 = Definition.create(word_id: word1.id, user_id: user1.id, subdivision_id: subdivision1.id, body: "End of business", tag_ids: [tag1.id])
# def2 = Definition.create(word_id: word2.id, user_id: user1.id, subdivision_id: subdivision2.id, body: "Close of business", tag_ids: [tag3.id, tag4.id] )
# def3 = Definition.create(word_id: word3.id, user_id: user2.id, subdivision_id: subdivision3.id, body: "To get in contact with", tag_ids: [tag1.id, tag4.id])
# def4 = Definition.create(word_id: word4.id, user_id: user2.id, subdivision_id: subdivision1.id, body: "Mesh well", tag_ids: [tag2.id, tag4.id])
# subdivmgmt1 = SubdivisionManagement.create(user_id: user1.id, subdivision_id: subdivision1.id)
# subdivmgmt2 = SubdivisionManagement.create(user_id: user2.id, subdivision_id: subdivision2.id)
# subdivmgmt3 = SubdivisionManagement.create(user_id: user2.id, subdivision_id: subdivision3.id)

# Users
20.times do |i|
  User.create(email: Faker::Internet.free_email, password: Faker::Internet.password, subdivision_id: i, admin: false)
end

User.create(email: "demouser@gmail.com", password: "password", subdivision_id: 1, admin: false)
User.create(email: "demoadmin@gmail.com", password: "password", subdivision_id: 1, admin: true)

Company.create(name: "Startup Inc")

20.times do
  Subdivision.create(name: Faker::Commerce.department, company_id: 1)
end

(1..11).each do
  Tag.create(name: Faker::Lorem.word)
end

100.times do
  Word.create(name: Faker::Company.catch_phrase, company_id: 1)
end

(1..100).each do |i|
  5.times do
    Definition.create(word_id: i, user_id: (1..20).to_a.sample, subdivision_id: (1..20).to_a.sample,
                      body: Faker::Lorem.sentences, tag_ids: (1..10).to_a.sample(3), company_id: 1)
  end
end

#Curriculums
(1..20).each do |i|
  Curriculum.create(user_id: i, name: Faker::Company.bs,
                    description: Faker::Lorem.sentence, definition_ids: (1..500).to_a.sample(10), company_id: 1)
end

#Messages

#Favorites