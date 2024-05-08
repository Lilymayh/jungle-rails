require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject(:user) { described_class.new(email: 'test@test.com', password: 'password', password_confirmation: 'password', first_name: 'John', last_name: 'Doe') }
    
    context 'when password and password_confirmation match' do
      it 'should be valid' do
      expect(user).to be_valid
    end
  end

    context 'when password and password_confirmation do not match' do
      it 'should not be valid' do
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Passwords do not match")
    end
  end

  context 'when email is not unique' do
    it 'should not be valid' do
      user.save
      duplicate_user = described_class.new(email: 'test@test.com', password: 'password', password_confirmation: 'password', first_name: 'Jane', last_name: 'Doe')
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors.full_messages).to include("Email has already been taken")
    end
  end

  context 'when email is not present' do
    it 'should not be valid' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
  end

  context 'when first name is not present' do
    it 'should not be valid' do
      user.first_name = nil
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end
  end

  context 'when last name is not present' do
    it 'should not be valid' do
      user.last_name = nil
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end
  end
end

context 'when password is too short' do
  it 'should not be valid' do
    user.password = 'short'
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include('Password is too short (minimum is 8 characters)')
  end
end
end

describe '.authenticate_with_credentials' do
  # Examples for this class method here

  let(:user) { User.create(email: 'test@example.com', password: 'password') }

  context 'when email and password are correct' do
    it 'should return the user' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end
  end

  context 'when email is incorrect' do
    it 'should return nil' do
      authenticated_user = User.authenticate_with_credentials('wrong@example.com', 'password')
      expect(authenticated_user).to be_nil
    end
  end

  context 'when password is incorrect' do
    it 'should return nil' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end
  end

  context 'when email has leading/trailing spaces' do
    it 'should return the user' do
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end
  end

  context 'when email has different cases' do
    it 'should return the user' do
      authenticated_user = User.authenticate_with_credentials('Test@Example.Com', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
  context 'when email contains mixed uppercase and lowercase letters' do
    it 'should return the user' do
      user = User.create(email: 'ExAmPlE@domain.COM', password: 'password')
      authenticated_user = User.authenticate_with_credentials('ExAmPlE@domain.COM', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
  
  context 'when email contains leading/trailing spaces and mixed cases' do
    it 'should return the user' do
      user = User.create(email: '  ExAmPlE@domain.CoM  ', password: 'password')
      authenticated_user = User.authenticate_with_credentials('  ExAmPlE@domain.CoM  ', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
  
  context 'when email or password is invalid' do
    it 'should return nil' do
      authenticated_user = User.authenticate_with_credentials('invalid@example.com', 'password')
      expect(authenticated_user).to be_nil
    end
  
    it 'should return nil' do
      authenticated_user = User.authenticate_with_credentials('example@example.com', 'invalid_password')
      expect(authenticated_user).to be_nil
    end
  end
end

