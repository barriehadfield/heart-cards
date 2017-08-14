require 'rails_helper'

RSpec.describe Update, :type => :model do

  let(:member) { Member.new(first_name: 'John', last_name: 'Smith', email: 'johm@smith.com', password: 'Test1234567') }
  let(:heart) { Heart.new(name: 'I am a test', created_by: member, updated_by: member) }

  subject {
    described_class.new(body: 'I am an update', heart: heart, member: member, category: :happiness)
  }

  it "should be valid with valid data" do
    expect(subject).to be_valid
  end

  it 'should be invalid without heart' do
    subject.heart = nil
    expect(subject).to_not be_valid
  end

  it 'should be invalid without member' do
    subject.member = nil
    expect(subject).to_not be_valid
  end

  it 'should be invalid without category' do
    subject.category = nil
    expect(subject).to_not be_valid
  end

end
