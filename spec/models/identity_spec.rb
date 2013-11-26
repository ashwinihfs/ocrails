require 'spec_helper'

describe Identity do
  describe 'Model Tests' do
    it 'SHOULD NOT be valid as a bare record' do
      i = Identity.new
      expect(i).to_not be_valid
    end

    it 'SHOULD be valid if all the MANDATORY parameters are filled in' do
      i = Identity.new
      expect(i).to_not be_valid
      i.name = 'Example User'
      expect(i).to_not be_valid
      i.email = 'user@example.com'
      expect(i).to_not be_valid
      i.password = 'SuperSecret'
      expect(i).to_not be_valid
      i.password_confirmation = 'SuperSecret'
      expect(i).to be_valid
    end

    it 'SHOULD NOT be valid if the Passwords do not match' do
      i = Identity.new
      expect(i).to_not be_valid
      i.name = 'Example User'
      expect(i).to_not be_valid
      i.email = 'user@example.com'
      expect(i).to_not be_valid
      i.password = 'SuperSecret'
      expect(i).to_not be_valid
      i.password_confirmation = 'SecretSuper'
      expect(i).to_not be_valid
    end

    it 'SHOULD NOT be valid if the email has already been taken' do
      i0 = Identity.new
      expect(i0).to_not be_valid
      i0.name = 'Example User'
      expect(i0).to_not be_valid
      i0.email = 'user@example.com'
      expect(i0).to_not be_valid
      i0.password = 'SuperSecret'
      expect(i0).to_not be_valid
      i0.password_confirmation = 'SuperSecret'
      expect(i0).to be_valid
      i0.save

      i1 = Identity.new
      expect(i1).to_not be_valid
      i1.name = 'Another User'
      expect(i1).to_not be_valid
      i1.email = 'usEr@example.com'
      expect(i1).to_not be_valid
      i1.password = 'SuperSecret'
      expect(i1).to_not be_valid
      i1.password_confirmation = 'SuperSecret'
      expect(i1).to_not be_valid
    end
  end
end
