require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
  before(:each) do
    @user = User.new
  end

  it 'saves with all fields filled in' do
    complete_user = User.new(name: 'a', email: 'email@email.com', password: 'apples', password_confirmation: 'apples')
    complete_user.save
    expect(complete_user).to be_valid
  end
  
  it 'is invalid without a name' do
    expect(@user).to_not be_valid
    expect(@user.errors.messages[:name]).to include('can\'t be blank')
  end

  it 'is invalid without a password' do
    expect(@user).to_not be_valid
    expect(@user.errors.messages[:password]).to include('can\'t be blank')
  end
  
  it 'is invalid if password and confirmation do not match' do
    complete_user = User.new(name: 'a', email: 'email@email.com', password: 'apples', password_confirmation: 'apples')
    complete_user2 = User.new(name: 'b', email: 'email@email.com', password: 'apples', password_confirmation: 'APPLES')
    complete_user.save
    complete_user2.save
    expect(complete_user.password).to eq(complete_user.password_confirmation)
    expect(complete_user2.password).to_not eq(complete_user2.password_confirmation)
  end
  
  it 'is invalid without an email' do
    expect(@user).to_not be_valid
    expect(@user.errors.messages[:email]).to include('can\'t be blank')
  end

  it 'is invalid without a unique email' do
    complete_user = User.new(name: 'a', email: 'email@email.com', password: 'apples', password_confirmation: 'apples')
    complete_user2 = User.new(name: 'b', email: 'email@email.com', password: 'APPLES', password_confirmation: 'APPLES')
    complete_user.save
    complete_user2.save
    expect(complete_user).to be_valid
    expect(complete_user2).to_not be_valid
    expect(complete_user2.errors.messages[:email]).to include('has already been taken')
  end

  it 'is invalid if the password is under the minimum length' do
    complete_user = User.new(name: 'a', email: 'email@email.com', password: 'apples', password_confirmation: 'apples')
    complete_user2 = User.new(name: 'b', email: 'email@email.com', password: 'apple', password_confirmation: 'apple')
    complete_user.save
    complete_user2.save
    expect(complete_user).to be_valid
    expect(complete_user2).to_not be_valid
    expect(complete_user2.errors.messages[:password]).to include("is too short (minimum is 6 characters)")
    expect(complete_user2.errors.messages[:password_confirmation]).to include("is too short (minimum is 6 characters)")
  end
end

describe '.authenticate_with_credentials' do

  it 'should authenticate with valid password and email' do
    user = User.new(name: 'a', email: 'email@email.com', password: 'apples', password_confirmation: 'apples')
    user.save
  valid_user = User.authenticate_with_credentials('email@email.com', 'apples')
  expect(valid_user).to eq(user)
  end

  it 'should authenticate if user uses wrong casing' do
    user = User.new(name: 'a', email: 'email@email.com', password: 'apples', password_confirmation: 'apples')
    user.save
  valid_user = User.authenticate_with_credentials('eMail@email.com', 'apples')
  expect(valid_user).to eq(user)
  end

  it 'should authenticate if user adds space to front or end' do
    user = User.new(name: 'a', email: 'email@email.com', password: 'apples', password_confirmation: 'apples')
    user.save
  valid_user = User.authenticate_with_credentials(' email@email.com ', 'apples')
  expect(valid_user).to eq(user)
  end



end
end
