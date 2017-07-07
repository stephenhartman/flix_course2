require 'rails_helper'

describe 'Signing out' do
  it 'logs out the user' do
    user = user.create!(user_attributes)
    sign_in(user)

    click_link('Sign Out')

    expect(page).to have_text('Signed out')
    expect(page).to_not have_link('Sign Out')
    expect(page).to have_link('Sign In')
  end
end
