require 'spec_helper'

feature 'Password Reset Controller (Local Identity Provider)' do

  before (:each) do
    OmniAuth.config.test_mode = false
    @original_identity=Identity.create(name: 'Original User',email: 'original_user@example.com',
                                       password: 'ICantRemember', password_confirmation: 'ICantRemember')
    clear_emails

  end


  scenario 'Request a Password Reset Email' do
    visit sign_out_path
    visit root_path
    page.should have_text 'Sign In'
    click_link 'Sign In'
    page.should have_text 'Forgot your Password?'
    click_link 'Forgot your Password?'
    page.should have_text('password reset code')
    fill_in 'E-Mail', with: 'original_user@example.com'
    click_button 'Reset Password'
    page.current_url.should == root_url
    page.should have_text 'Email sent with password reset instructions.'
  end

  scenario 'Try and correctly reset your password from a Password Reset E-Mail' do
    visit sign_out_path
    visit root_path
    page.should have_text 'Sign In'
    click_link 'Sign In'
    page.should have_text 'Forgot your Password?'
    click_link 'Forgot your Password?'
    page.should have_text('password reset code')
    fill_in 'E-Mail', with: 'original_user@example.com'
    click_button 'Reset Password'
    page.current_url.should == root_url
    page.should have_text 'Email sent with password reset instructions.'

    # Now to process the Reset Email
    @original_identity = Identity.where(email: 'original_user@example.com').first
    open_email('original_user@example.com')
    current_email.should have_text 'Original User'
    current_email.click_link "#{edit_password_reset_url(@original_identity.password_reset_token)}"
    fill_in 'Password', with: 'ICanRememberThis'
    fill_in 'Password Confirmation', with: 'ICanRememberThis'
    click_button 'Update Password'
    page.should have_text 'Password has been reset.'
  end

  scenario 'Try and incorrectly reset your password from a Password Reset E-Mail (Passwords Different)' do
    visit sign_out_path
    visit root_path
    page.should have_text 'Sign In'
    click_link 'Sign In'
    page.should have_text 'Forgot your Password?'
    click_link 'Forgot your Password?'
    page.should have_text('password reset code')
    fill_in 'E-Mail', with: 'original_user@example.com'
    click_button 'Reset Password'
    page.current_url.should == root_url
    page.should have_text 'Email sent with password reset instructions.'

    # Now to process the Reset Email
    @original_identity = Identity.where(email: 'original_user@example.com').first
    open_email('original_user@example.com')
    current_email.should have_text 'Original User'
    current_email.click_link "#{edit_password_reset_url(@original_identity.password_reset_token)}"
    fill_in 'Password', with: 'ICanRememberThis'
    fill_in 'Password Confirmation', with: 'ICannotRememberThis'
    click_button 'Update Password'
    page.should have_text "Form is invalid Password confirmation doesn't match Password"
  end

  scenario 'Try and reset your password from a Password Reset E-Mail where the link has expired' do
    visit sign_out_path
    visit root_path
    page.should have_text 'Sign In'
    click_link 'Sign In'
    page.should have_text 'Forgot your Password?'
    click_link 'Forgot your Password?'
    page.should have_text('password reset code')
    fill_in 'E-Mail', with: 'original_user@example.com'
    click_button 'Reset Password'
    page.current_url.should == root_url
    page.should have_text 'Email sent with password reset instructions.'

    # Now to process the Reset Email
    Timecop.travel(Time.now + 6.hours)
    @original_identity = Identity.where(email: 'original_user@example.com').first
    open_email('original_user@example.com')
    current_email.should have_text 'Original User'
    current_email.click_link "#{edit_password_reset_url(@original_identity.password_reset_token)}"
    fill_in 'Password', with: 'ICanRememberThis'
    fill_in 'Password Confirmation', with: 'ICanRememberThis'
    click_button 'Update Password'
    Timecop.return
    page.should have_text 'Password reset has expired - Please generate a new one.'
  end
end
