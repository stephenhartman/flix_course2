require 'rails_helper'

describe 'Signing in' do
  it "prompts for an email and password" do
    visit root_url
    click_link 'Sign In'

    expect(current_path).to eq(signin_path)
    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
  end

  it "is valid with the right combination" do
    user = User.create!(user_attributes)
    visit root_url
    click_link 'Sign In'

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign In"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Welcome back, #{user.username}!")
  end

  it "is invalid with the wrong combination" do
    user = User.create!(user_attributes)
    visit root_url
    click_link 'Sign In'

    fill_in "Email", with: user.email
    fill_in "Password", with: "Bad Match"

    click_button "Sign In"

    expect(current_path).to_not eq(user_path(user))
    expect(page).to have_text("Invalid")
  end
end
