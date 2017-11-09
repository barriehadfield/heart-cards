require 'rails_helper'

RSpec.describe Report, :type => :model do

  let(:member) { Member.new(first_name: 'John', last_name: 'Smith', email: 'johm@smith.com', password: 'Test1234567') }
  let(:heart) { Heart.new(name: 'I am a test', created_by: member, updated_by: member) }

  subject {
    described_class.new(body: 'I am an report', heart: heart, member: member, category: :happiness)
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

  it 'should scope with for_heart_categories' do
    subject.save
    expect(Report.for_heart_category(heart, :happiness).count).to equal(1)
  end

  it 'should save using the Operation' do
    skip 'need to be able to set the current user'
    expect(Report.count).to equal(0)
    Member.current = member
    SaveReportOp.run(heart: heart, report: subject, category: :retention)
    expect(Report.count).to eq(1)
  end

end
