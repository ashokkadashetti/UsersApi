require 'rails_helper'

describe Candidate, type: :model do

  subject {
    Candidate.new(id: 1, user_id: 1, name: 'Ashok', email: 'ashok@gmail.com', created_at: Time.now, updated_at: Time.now)
  }

  it 'is validate without name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
  end

  describe 'association' do
    it { is_expected.to have_and_belong_to_many(:projects) }
  end

end
