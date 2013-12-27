require 'spec_helper'

describe Tag do
  it "should have a name" do
    tag = Tag.new
    expect(tag.errors_on(:name)).to include("can't be blank")
  end
end
