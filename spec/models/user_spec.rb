require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "is invalid if first_name is not provided" do
      @user = User.create(first_name: nil, last_name: 'Schiavon', email: '123@test.com', password: '12345678', password_confirmation: '12345678')

      expect(@user.errors.full_messages).to eql(["First name can't be blank"])
    end

    it "is invalid if last_name is not provided" do
      @user = User.create(first_name: 'Veronica', last_name: nil, email: '123@test.com', password: '12345678', password_confirmation: '12345678')

      expect(@user.errors.full_messages).to eql(["Last name can't be blank"])
    end

    it "is invalid if email is not provided" do
      @user = User.create(first_name: 'Veronica', last_name: 'Schiavon', email: nil, password: '12345678', password_confirmation: '12345678')

      expect(@user.errors.full_messages).to eql(["Email can't be blank"])
    end

    it "is invalid if password and password_confirmation fields are not provided" do
      @user = User.create(first_name: 'Veronica', last_name: 'Schiavon', email: '123@test.com')

      expect(@user.errors.full_messages).to eql(["Password can't be blank", "Password can't be blank", "Password is too short (minimum is 8 characters)", "Password confirmation can't be blank"]

      )
      expect(@user).to be_invalid
    end
    
    it "is invalid if password and password_confirmation do not match" do
      @user = User.create(password: '12345678', password_confirmation: 'abcdefgh', first_name: 'Veronica', last_name: 'Schiavon', email: '123@test.com')
      
      expect(@user.errors.full_messages).to eql(["Password confirmation doesn't match Password"])
      expect(@user).to be_invalid
    end

    it "is invalid if email already exists" do
      @user1 = User.create(first_name: 'Veronica', last_name: 'Schiavon', email: '123@TEST.com', password: '12345678', password_confirmation: '12345678')
      expect(@user1).to be_valid

      @user2 = User.create(first_name: 'FirstName', last_name: 'LastName', email: '123@test.COM', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      expect(@user2.errors.full_messages).to eql(["Email has already been taken"])
      expect(@user2).to be_invalid
    end

    it "is invalid if password doesn't meet minimum length of 8 characters" do
      @user = User.create(first_name: 'Veronica', last_name: 'Schiavon', email: '123@test.com', password: '123', password_confirmation: '123')

      expect(@user.errors.full_messages).to eql(["Password is too short (minimum is 8 characters)"])
      expect(@user).to be_invalid
    end 

  end


  describe '.authenticate_with_credentials' do

    it 'logs in when correct email and password are provided' do
      @user = User.create(first_name: 'Veronica', last_name: 'Schiavon', email: '123@test.com', password: '12345678', password_confirmation: '12345678')

      expect(User.authenticate_with_credentials('123@test.com', '12345678')).to eq(@user)
    end

    it 'does not log in when incorrect email is provided' do
      @user = User.create(first_name: 'Veronica', last_name: 'Schiavon', email: '123@test.com', password: '12345678', password_confirmation: '12345678')

      expect(User.authenticate_with_credentials('abc@test.com', '12345678')).to be_nil
    end

    it 'does not log in when incorrect password is provided' do
      @user = User.create(first_name: 'Veronica', last_name: 'Schiavon', email: '123@test.com', password: '12345678', password_confirmation: '12345678')

      expect(User.authenticate_with_credentials('123@test.com', 'abcdefgh')).to be_nil
    end

    it 'should log in even if email has not been trimmed' do
      @user = User.create(first_name: 'Veronica', last_name: 'Schiavon', email: '123@test.com', password: '12345678', password_confirmation: '12345678')

      expect(User.authenticate_with_credentials('   123@test.com   ', '12345678')).to eq(@user)
    end

    it 'should log if email is the same but case is not identical' do
      @user = User.create(first_name: 'Veronica', last_name: 'Schiavon', email: 'eXAmple@domain.com', password: '12345678', password_confirmation: '12345678')

      expect(User.authenticate_with_credentials('EXAMPLe@DOMAIN.CoM', '12345678')).to eq(@user)
    end
  end
  
end
