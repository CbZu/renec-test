require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: 'test@example.com', password: 'password') }

  describe 'associations' do
    it { should have_many(:video) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'password encryption' do
    it 'encrypts the password' do
      expect(subject.password_digest).not_to be_blank
    end
end
end
