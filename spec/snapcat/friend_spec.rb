require 'spec_helper'

describe Snapcat::Friend do
  before(:all) do
    RequestStub.stub_friend
  end

  describe '.new' do
    it 'sets allowed fields'
    it 'sets client'
    it 'sets type'
  end

  describe '#delete' do
    it 'deletes this friend' do
      ux = UserExperience.new
      ux.login
      friend = ux.friend

      result = friend.delete

      result.success?.must_equal true
    end
  end

  describe '#set_display_name' do
    it 'sets display name' do
      ux = UserExperience.new
      ux.login
      friend = ux.friend

      result = friend.set_display_name(UserExperience::FRIEND_DISPLAY_NAME)

      result.success?.must_equal true
    end
  end
end
