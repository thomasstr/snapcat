require 'spec_helper'

describe Snapcat::User do
  describe '#login' do
    it 'logs the user in'
  end

  describe '#block' do
    it 'blocks a user'
  end

  describe '#clear_feed' do
    it 'clears a users feed'
  end

  describe '#fetch_updates' do
    it 'resets all of the users update fields'
  end

  describe '#register' do
    it 'allows a user to register'
  end

  describe '#unblock' do
    it 'unblocks a user'
  end

  describe '#update_email' do
    it 'updates a users email'
  end

  describe '#update_privacy' do
    it 'updates a users privacy setting'
  end
end
