require 'spec_helper'

describe Word do
  it "should validate that the new word is unique" do
    word1 = Word.create(name: Faker::Company.catch_phrase)
    word2 = Word.new(name: word1.name)
    expect(word2).to_not be_valid
  end
end
