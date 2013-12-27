require 'spec_helper'
require 'faker'

describe Definition do
  let(:incomplete_definition) { Definition.new }

  it "should belong to a word" do
    expect(incomplete_definition).to have_at_least(1).error_on(:word_id)
  end
  
  it "should belong to a user" do
    expect(incomplete_definition).to have_at_least(1).error_on(:user_id)
  end
  
  it "should belong to a subdivision" do
    expect(incomplete_definition).to have_at_least(1).error_on(:subdivision_id)
  end
  
  it "should allow tagging" do
    complete_definition = Definition.create(body: Faker::Lorem.sentence, user_id: 1, word_id: 1, subdivision_id: 1)
    tag = Tag.create(name: "Sample Tag")
    complete_definition.tag_ids = tag.id
    expect(complete_definition.tags[0].id).to eq(tag.id)
  end
end
