require 'spec_helper'

describe User do
  describe 'Model Tests' do
    it 'SHOULD NOT be valid as a bare record' do
      u = User.new
      expect(u).to_not be_valid
    end

    it 'SHOULD be valid if all the MANDATORY parameters are filled in' do
      u = User.new
      expect(u).to_not be_valid
      u.provider = 'Example_Provider'
      expect(u).to_not be_valid
      u.uid = '1234567890'
      expect(u).to_not be_valid
      u.name = 'Example User'
      expect(u).to be_valid
    end
  end
end
