require 'spec_helper'

describe User do
  describe 'Model Tests' do
    it 'SHOULD NOT be valid as a bare record' do
      user = User.new
      user.should_not be_valid
    end

    it 'SHOULD be valid if all the MANDATORY parameters are filled in' do
      user = User.new
      user.should_not be_valid
      user.provider = 'Example_Provider'
      user.should_not be_valid
      user.uid = '1234567890'
      user.should_not be_valid
      user.name = 'Example User'
      user.should be_valid
    end
  end
end
