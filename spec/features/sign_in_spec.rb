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
    expect(page).to have_link(user.name)
    expect(page).to_not have_link("Sign In")
    expect(page).to_not have_link("Sign Up")
    expect(page).to have_link('Sign Out')
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
    expect(page).to_not have_link(user.name)
    expect(page).to have_link("Sign In")
    expect(page).to have_link("Sign Up")
    expect(page).to_not have_link('Sign Out')
  end

  it "redirects to the intended page" do
    user = User.create!(user_attributes)
    visit users_url

    expect(current_path).to eq(new_session_path)

    sign_in(user)

    expect(current_path).to eq(users_path)
  end
end
