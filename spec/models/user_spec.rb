require 'rails_helper'

describe 'User' do
  it "requires a name" do
    user = User.new(name: "")
    user.valid?
    expect(user.errors[:name].any?).to eq(true)
  end

  it "requires an email" do
    user = User.new(email: "")
    user.valid?
    expect(user.errors[:email].any?).to eq(true)
  end

  it "accepts properly formmated email addresses" do
    emails = %w(user@example.com first.last@example.com)
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(false)
    end
  end

  it "rejects improperly formatted email addresses" do
    emails = %w(@ user@ @example.com)
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(true)
    end
  end

  it "requires unique, case insensitive email addresses" do
    user1 = User.create!(user_attributes)
    user2 = User.new(email: user1.email.upcase)
    user2.valid?
    expect(user2.errors[:email].first).to eq("has already been taken")
  end

  it "is valid with example attributes" do
    user = User.new(user_attributes)
    user.valid?
    expect(user.errors.any?).to eq(false)
  end

  it "requires a password" do
    user = User.new(password: "")
    user.valid?
    expect(user.errors[:password].any?).to eq(true)
  end

  it "requires a password confirmation when a password is present" do
    user = User.new(password: "secret", password_confirmation: "")
    user.valid?
    expect(user.errors[:password_confirmation].any?).to eq(true)
  end

  it "requires the confirmation to equal the password" do
    user = User.new(password: "secret", password_confirmation: "nomatch")
    user.valid?
    expect(user.errors[:password_confirmation].first).to eq("doesn't match Password")

  end

  it "does not require a password when updating" do
    user = User.new(user_attributes)
    user.password = ""
    expect(user.valid?).to eq(true)
  end

  it "automaticcaly encrypts a password into the password_digest attribute" do
    user = User.new(password: "secret")
    expect(user.password_digest.present?).to eq(true)
  end
end
