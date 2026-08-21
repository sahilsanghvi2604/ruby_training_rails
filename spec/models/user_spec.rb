require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'is valid with factory generated data' do
    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    user.email = nil
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email' do
    create(:user, email: 'same@example.com')
    user.email = 'same@example.com'
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include('has already been taken')
  end

  it 'is invalid when password is too short' do
    user.password = '123'
    user.password_confirmation = '123'
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
  end
end