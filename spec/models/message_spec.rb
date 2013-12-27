require 'spec_helper'

describe Message do
  let(:incomplete_message) { FactoryGirl.build(:incomplete_message) }
  
  it "should have a subject" do
    expect(incomplete_message.errors_on(:subject)).to include("can't be blank")
  end
  
  it "should have a body" do
    expect(incomplete_message.errors_on(:body)).to include("can't be blank")
  end
  
  it "should be unread by default" do
    expect(incomplete_message.read).to eq(false)
  end
  
  it { should belong_to(:sender) }
  it { should belong_to(:recipient) }
end
