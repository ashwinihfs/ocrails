require 'spec_helper'

feature 'OmniAuth in Short Circuit Mode (External Providers)' do

  before (:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] =
        OmniAuth::AuthHash.new({
            :provider => 'twitter',
            :uid => '12354567890',
            :info => {
              :name => 'Example User'
            }
        })
  end


  scenario 'Create User Account with Twitter' do
    visit '/auth/twitter'
    expect(page).to have_text('Hello Example User - You are now Signed In')
  end

  scenario 'Sign In / Sign Out from the Application' do
    visit '/auth/twitter'
    expect(page).to have_text('Hello Example User - You are now Signed In')
    visit '/sign_out'
    expect(page).to have_text('Goodbye - You are now Signed Out')
  end

  scenario 'Emulate Failed Authorization from the Provider' do
    OmniAuth.config.mock_auth[:twitter] =  :system_authentication_error
    visit '/auth/twitter'
    expect(page).to have_text('Authentication failed, please try again')
  end
end
