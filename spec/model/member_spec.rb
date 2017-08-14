require 'rails_helper'

RSpec.describe Member, :type => :model do

  subject {
    described_class.new(first_name: 'John', last_name: 'Smith', email: 'johm@smith.com', password: 'Test1234567')
  }

  it "should be valid with valid data" do
    expect(subject).to be_valid
  end

  it 'should be invalid without email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end
end
