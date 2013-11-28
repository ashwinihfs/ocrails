require 'spec_helper'

describe Identity do
  describe 'Model Tests' do
    it 'SHOULD NOT be valid as a bare record' do
      identity = Identity.new
      identity.should_not be_valid
    end

    it 'SHOULD be valid if all the MANDATORY parameters are filled in' do
      identity = Identity.new
      identity.should_not be_valid
      identity.name = 'Example User'
      identity.should_not be_valid
      identity.email = 'user@example.com'
      identity.should_not be_valid
      identity.password = 'SuperSecret'
      identity.should_not be_valid
      identity.password_confirmation = 'SuperSecret'
      identity.should be_valid
    end

    it 'SHOULD NOT be valid if the Passwords do not match' do
      identity = Identity.new
      identity.should_not be_valid
      identity.name = 'Example User'
      identity.should_not be_valid
      identity.email = 'user@example.com'
      identity.should_not be_valid
      identity.password = 'SuperSecret'
      identity.should_not be_valid
      identity.password_confirmation = 'SecretSuper'
      identity.should_not be_valid
    end

    it 'SHOULD NOT be valid if the email has already been taken' do
      identity_a = Identity.new
      identity_a.should_not be_valid
      identity_a.name = 'Example User'
      identity_a.should_not be_valid
      identity_a.email = 'user@example.com'
      identity_a.should_not be_valid
      identity_a.password = 'SuperSecret'
      identity_a.should_not be_valid
      identity_a.password_confirmation = 'SuperSecret'
      identity_a.should be_valid
      identity_a.save

      identity_b = Identity.new
      identity_b.should_not be_valid
      identity_b.name = 'Another User'
      identity_b.should_not be_valid
      identity_b.email = 'usEr@example.com'
      identity_b.should_not be_valid
      identity_b.password = 'SuperSecret'
      identity_b.should_not be_valid
      identity_b.password_confirmation = 'SuperSecret'
      identity_b.should_not be_valid
    end
  end
end
