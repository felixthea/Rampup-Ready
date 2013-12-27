require 'spec_helper'
require 'faker'

describe User do
  
  let(:subdivision) { Subdivision.create(name: Faker::Commerce.department) }
  
  it "validates the presence of email" do
    user = User.new
    expect(user.errors_on(:email)).to include("can't be blank")
  end
  
  it "validates uniqueness of email" do
    user1 = User.create(email: Faker::Internet.email, password: Faker::Internet.password, subdivision_id: subdivision.id)
    user2 = User.create(email: user1.email, password: Faker::Internet.password, subdivision_id: subdivision.id)
    expect(user2.errors_on(:email)).to include("has already been taken")
  end
  
  it "creates users with admin set to false by default" do
    not_admin = User.create(email: Faker::Internet.email, password: Faker::Internet.password, subdivision_id: subdivision.id)
    expect(not_admin.admin).to eq(false)
  end
  
end
