require 'spec_helper'

describe Snapcat::User do
  before(:all) do
    RequestStub.stub_user
  end

  describe '#block' do
    it 'blocks a user' do
      ux = UserExperience.new
      ux.login
      user = ux.user

      result = user.block(UserExperience::FRIEND_USERNAME)

      result.success?.must_equal true
    end
  end

  describe '#clear_feed' do
    it 'clears a users feed' do
      ux = UserExperience.new
      ux.login
      user = ux.user

      result = user.clear_feed

      result.success?.must_equal true
    end
  end

  describe '#fetch_updates' do
    it 'resets all of the users update fields' do
      ux = UserExperience.new
      ux.login
      user = ux.user

      result = user.fetch_updates

      result.success?.must_equal true
      user.friends.length.must_equal 5
    end
  end

  describe '#login' do
    it 'logs the user in' do
      ux = UserExperience.new
      user = ux.user

      result = user.login(UserExperience::PASSWORD)

      result.success?.must_equal true
    end

    it 'sets updatable fields' do
      ux = UserExperience.new
      user = ux.user

      user.login(UserExperience::PASSWORD)

      user.friends.length.must_equal 4
      user.snaps_received.length.must_equal 1
      user.snaps_sent.length.must_equal 0
      user.data.must_equal ResponseHelper.hash_for(:login)
    end
  end

  describe '#logout' do
    it 'logs the user out' do
      ux = UserExperience.new
      ux.login
      user = ux.user

      result = user.logout

      result.success?.must_equal true
    end
  end

  describe '#register' do
    it 'allows a user to register' do
      client = Snapcat::Client.new(UserExperience::USERNAME)
      user = client.user

      result = user.register(
        UserExperience::BIRTHDAY,
        UserExperience::EMAIL,
        UserExperience::PASSWORD
      )

      result.success?.must_equal true
    end
  end

  describe '#send_snap' do
    it 'send a snaps to single user' do
      ux = UserExperience.new
      ux.login
      user = ux.user

      result = user.send_snap(
        UserExperience::MEDIA_ID,
        UserExperience::RECIPIENT,
        UserExperience::VIEW_DURATION
      )

      result.success?.must_equal true
    end

    it 'send a snaps to multiple users' do
      ux = UserExperience.new
      ux.login
      user = ux.user

      result = user.send_snap(
        UserExperience::MEDIA_ID,
        UserExperience::RECIPIENTS,
        UserExperience::VIEW_DURATION
      )

      result.success?.must_equal true
    end
  end

  describe '#unblock' do
    it 'unblocks a user' do
      ux = UserExperience.new
      ux.login
      user = ux.user

      result = user.unblock(UserExperience::FRIEND_USERNAME)

      result.success?.must_equal true
    end
  end

  describe '#update_email' do
    it 'updates a users email' do
      ux = UserExperience.new
      ux.login
      user = ux.user

      result = user.update_email(UserExperience::EMAIL)

      result.success?.must_equal true
    end
  end

  describe '#update_privacy' do
    it 'updates a users privacy setting' do
      ux = UserExperience.new
      ux.login
      user = ux.user

      result = user.update_privacy(Snapcat::User::Privacy::EVERYONE)

      result.success?.must_equal true
    end
  end

  describe '#upload' do
    it 'uploads a snap' do
      skip 'this works but need to stub out octet-stream not as a string'
      ux = UserExperience.new
      ux.login
      user = ux.user

      result = user.upload(DataHelper.data_for(:decrypted))

      result.success?.must_equal true
    end
  end
end
