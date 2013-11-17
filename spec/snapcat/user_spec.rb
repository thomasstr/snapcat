require 'spec_helper'

describe Snapcat::User do
  describe '#block' do
    it 'blocks a user' do
      login_user

      result = @user.block('iluvkittens3')

      result.must_equal {}
    end
  end

  describe '#clear_feed' do
    it 'clears a users feed' do
      login_user

      result = @user.clear_feed

      result.must_equal {}
    end
  end

  describe '#fetch_updates' do
    it 'resets all of the users update fields' do
      login_user

      result = @user.fetch_updates

      result.must_equal {}
    end
  end

  describe '#login' do
    it 'logs the user in' do
      client = Snapcat::Client.new('iluvkittens')
      user = client.user

      result = user.login('topsecret')

      client.logged_in.must_equal true
      result.must_equal true
      user.snaps_received.must_equal = []
      user.snaps_sent.must_equal = []
      user.updates.must_equal = []
    end
  end

  describe '#logout' do
    it 'logs the user out' do
      login_user

      result = @user.logout

      result.must_equal true
    end
  end

  describe '#register' do
    it 'allows a user to register' do
      client = Snapcat::Client.new('iluvkittens')
      user = client.user

      result = user.register('1990-01-30', 'test@exasdf0aample.com', 'topsecret')

      result.must_equal true
      client.logged_in.must_equal true
    end
  end

  describe '#send_snap' do
    it 'send a snap' do
      login_user

      result = @user.send_snap('media_id', %w(jim jane), 6)

      result.must_equal true
    end
  end

  describe '#unblock' do
    describe 'for someone who isnt a friend' do
      it 'fails to block' do
        login_user

        result = @user.unblock('randomperson')

        result.must_equal false
      end
    end

    describe 'for someone who is a friend' do
      it 'unblocks a user' do
        login_user

        result = @user.unblock('someone')

        result.must_equal true
      end
    end
  end

  describe '#update_email' do
    it 'updates a users email' do
      login_user

      result = @user.update_email('newemail@example.com')

      result.must_equal true
    end
  end

  describe '#update_privacy' do
    it 'updates a users privacy setting' do
      login_user

      result = @user.update_privacy(Snapcat::User::Privacy::EVERYONE)

      result.must_equal true
    end
  end

  describe '#upload' do
    it 'uploads a snap' do
      login_user

      result = @user.upload('asdf')

      result.must_equal 'a_media_id'
    end
  end

  def login_user
    @client = Snapcat::Client.new('iluvkittens')
    @user = @client.user
    @user.login('topsecret')
  end
end
