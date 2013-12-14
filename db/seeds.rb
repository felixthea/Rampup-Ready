# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user1 = User.create(email: "notadmin@gmail.com", password: "password", subdivision_id: 1, admin: false)
user2 = User.create(email: "admin@gmail.com", password: "password", subdivision_id: 1, admin: true)
word1 = Word.create(name: "EOD")
word2 = Word.create(name: "COB")
word3 = Word.create(name: "Touch base")
word4 = Word.create(name: "Synergy")
subdivision1 = Subdivision.create(name: "Engineering")
subdivision2 = Subdivision.create(name: "Finance")
subdivision3 = Subdivision.create(name: "Operations")
tag1 = Tag.create(name: "Financial Documents")
tag2 = Tag.create(name: "Ruby Gems")
tag3 = Tag.create(name: "Workflow terminology")
tag4 = Tag.create(name: "General terms")
def1 = Definition.create(word_id: word1.id, user_id: user1.id, subdivision_id: subdivision1.id, body: "End of business", tag_ids: [tag1.id])
def2 = Definition.create(word_id: word2.id, user_id: user1.id, subdivision_id: subdivision2.id, body: "Close of business", tag_ids: [tag3.id, tag4.id] )
def3 = Definition.create(word_id: word3.id, user_id: user2.id, subdivision_id: subdivision3.id, body: "To get in contact with", tag_ids: [tag1.id, tag4.id])
def4 = Definition.create(word_id: word4.id, user_id: user2.id, subdivision_id: subdivision1.id, body: "Mesh well", tag_ids: [tag2.id, tag4.id])
subdivmgmt1 = SubdivisionManagement.create(user_id: user1.id, subdivision_id: subdivision1.id)
subdivmgmt2 = SubdivisionManagement.create(user_id: user2.id, subdivision_id: subdivision2.id)
subdivmgmt3 = SubdivisionManagement.create(user_id: user2.id, subdivision_id: subdivision3.id)