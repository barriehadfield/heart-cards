require 'rails_helper'

RSpec.describe Heart, :type => :model do

  let(:member) { Member.new(first_name: 'John', last_name: 'Smith', email: 'johm@smith.com', password: 'Test1234567') }

  subject {
    described_class.new(name: 'I am a test', created_by: member, updated_by: member)
  }

  it "should be valid with valid data" do
    expect(subject).to be_valid
  end

  it "must have a valid created_by" do
    subject.created_by = nil
    expect(subject).to_not be_valid
  end

  it "must have a valid updated_by" do
    subject.updated_by = nil
    expect(subject).to_not be_valid
  end

  it "is correctly associated with member" do
    subject.save
    expect(member.created_hearts.count).to equal 1
    expect(member.updated_hearts.count).to equal 1
  end

end
