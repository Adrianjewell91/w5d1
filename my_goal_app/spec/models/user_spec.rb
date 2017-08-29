require 'rails_helper'

RSpec.describe User, type: :model do

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password_digest)}
  #
  # it {should validate_uniqueness_of(:email)}
  it {should validate_length_of(:password).is_at_least(6)}
  it {should have_many(:goals)}

  describe "#password=(password)" do
    it "should set the password_digest from password value"
  end

  describe "#is_password?(passowrd)" do
    context "when passed the correct password" do
      it "should return: true"
    end

    context "when passed invalid params" do
      it "should return: false"
    end
  end

  describe "password_encryption" do
    it "should not save passwords to the database" do
      FactoryGirl.create(:user)
      # user = User.create(email: "123@456.com", password: '123456')
      user = User.find_by(email: '123@456.com')
      expect(user.password).to eq(nil)
    end


    it "should use BCrypt to create password_digests" do
      expect(BCrypt::Password).to receive(:create)
      User.create(email: "123@456.com",password:"123456")
    end
  end

  describe "#generate_session_token" do
    it "generates a session_token with SecureRandom"
  end

  describe "#reset_session_token!" do
    it "sets a new session_token"
  end

  describe "#ensure_session_token" do
    it "should lazily assign the session token" do
      adrian = FactoryGirl.create(:user, email: 'adr@ian.com')
      expect(adrian.session_token).not_to be_nil
    end
  end

  describe "::find_by_credentials" do
    context "when passed valid params" do
      it "should return nil" do
        FactoryGirl.create(:user)
        user = User.find_by_credentials(
                      '123@456.com',
                      '12' )
        expect(user).to eq(nil)
      end
    end

    context "when passed invalid params" do
      it "should return the user object" do
        the_user = FactoryGirl.create(:user)
        user = User.find_by_credentials(
                      '123@456.com',
                      '123456' )
        expect(user).to eq(the_user)
      end
    end
  end
end
