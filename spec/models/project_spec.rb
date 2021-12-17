require 'rails_helper'

describe Project, type: :model do
  describe 'association' do
    it { is_expected.to have_and_belong_to_many(:candidates)}
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :idle }
    it { is_expected.to validate_presence_of :realtime }
    it { is_expected.to validate_presence_of :bill }
  end
end
