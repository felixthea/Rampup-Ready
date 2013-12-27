require 'spec_helper'

describe Curriculum do 
  let(:incomplete_curriculum) { FactoryGirl.build(:incomplete_curriculum) }
  it { should have_many(:definitions) }
  it { should have_many(:curriculum_faves) }
  it { should belong_to(:user) }
  
  it "should have a name" do
    expect(incomplete_curriculum.errors_on(:name)).to include("can't be blank")
  end
  
  it "should have a description" do
    expect(incomplete_curriculum.errors_on(:description)).to include("can't be blank")
  end    
  
  it "should have definitions" do
    expect(incomplete_curriculum.errors_on(:definitions)).to include("can't be blank")
  end
  
end
