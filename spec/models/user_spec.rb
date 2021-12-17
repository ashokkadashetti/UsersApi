require 'rails_helper'

describe User, type: :model do
  subject {
    User.new(name: 'Ashok', email: 'ashok@gmail.com', password: '123456', role: 'TL')
  }

  it 'name shoud present' do
    user = User.new(name: 'Ashok', email: 'ashok@gmail.com', password: '123456', role: 'TL')
    expect(user.name?).to eq(true)
  end

  it 'Length shoud match' do
    user = User.new(name: 'Ashok', email: 'ashok@gmail.com', password: '123456', role: 'admin')
    expect(user.role.size).to eq(5)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without role' do
    subject.role = nil
    expect(subject).to_not be_valid
  end

  describe 'association' do
    it{ is_expected.to have_many(:candidates)}
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
    it { is_expected.to validate_presence_of :role }
  end
end
