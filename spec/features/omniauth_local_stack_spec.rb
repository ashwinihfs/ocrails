require 'spec_helper'

feature 'OmniAuth in Full Stack Mode (Local Identity Provider)' do

  before (:each) do
    OmniAuth.config.test_mode = false
  end

  scenario 'Create User Account with Identity (All Parameters Correct)' do
    visit sign_in_path
    expect(page).to have_text('Create an Account')
    click_link 'Create an Account'
    expect(page).to have_text('Create Account')
    fill_in 'Name', with: 'Local User'
    fill_in 'E-Mail', with: 'someuser@example.com'
    fill_in 'Password', with: 'Secret123'
    fill_in 'Password Confirmation', with: 'Secret123'
    click_button 'Register'
    expect(page).to have_text('Hello Local User - You are now Signed In')
  end

  scenario 'DO NOT Create User Account with Identity (Password does not match confirmation)' do
    visit sign_in_path
    expect(page).to have_text('Create an Account')
    click_link 'Create an Account'
    expect(page).to have_text('Create Account')
    fill_in 'Name', with: 'Local User'
    fill_in 'E-Mail', with: 'someuser@example.com'
    fill_in 'Password', with: 'Secret123'
    fill_in 'Password Confirmation', with: 'Secret124'
    click_button 'Register'
    expect(page).to have_text("Password confirmation doesn't match Password Name")

  end
end
