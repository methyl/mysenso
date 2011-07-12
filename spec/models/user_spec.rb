require 'spec_helper'

describe User do
  before(:each) { Factory :user }
  it { should validate_presence_of :gender }
  it { should validate_presence_of :profession }
  it { should validate_numericality_of(:phone_number) }
  it { should belong_to :profession }
end
