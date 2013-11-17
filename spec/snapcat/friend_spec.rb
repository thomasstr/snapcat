require 'spec_helper'

describe Snapcat::Friend do
  describe '.new' do
    it 'sets allowed fields'
    it 'sets client'
    it 'sets type'
  end

  describe '#delete' do
    it 'deletes this friend' do
      login_user

      result = @friend.delete

      result.must_be true
    end
  end

  describe '#set_display_name' do
    it 'sets display name' do
      login_user

      result = @friend.set_display_name('McKitten')

      result.must_be true
    end
  end

  def login_user
    @client = Snapcat::Client.new('iluvkittens')
    @user = @client.user
    @user.login('topsecret')
    @friend = @user.friends.first
  end
end
