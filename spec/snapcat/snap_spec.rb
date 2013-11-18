require 'spec_helper'

describe Snapcat::Snap do
  before(:all) do
    RequestStub.stub_snap
  end

  describe '.new' do
    it 'converts fields' do
      skip 'need to set up snap_data'
      snap = Snapcat::Snap.new(
        nil,
        snap_data[:id],
        snap_data
      )

      snap.broadcast.must_equal snap_data[:broadcast]
      snap.broadcast_action_text.must_equal snap_data[:broadcast_action_text]
      snap.broadcast_hide_timer.must_equal snap_data[:broadcast_hide_timer]
      snap.broadcast_url.must_equal snap_data[:broadcast_url]
      snap.screenshot_count.must_equal snap_data[:c]
      snap.media_id.must_equal snap_data[:c_id]
      snap.id.must_equal snap_data[:id]
      snap.media_type.must_equal snap_data[:m]
      snap.recipient.must_equal snap_data[:rp]
      snap.sender.must_equal snap_data[:sn]
      snap.status.must_equal snap_data[:st]
      snap.sent.must_equal snap_data[:sts]
      snap.opened.must_equal snap_data[:ts]
      snap.client.must_be :nil?
    end

    it 'sets status to value object' do
      skip 'need to set up snap_data'
      snap = Snapcat::Snap.new(
        nil,
        snap_data[:id],
        snap_data
      )

      snap.status.code.must_equal snap.status
    end
  end

  describe '#media' do
    it 'retrieves media data' do
      skip 'this works but still have issues with decrypt in test suite'
      ux = UserExperience.new
      ux.login
      snap = ux.snap

      media = snap.media

      media.data.must_equal DataHelper.data_for(:decrypted)
    end
  end

  describe '#screenshot' do
    it 'records a screenshot' do
      skip 'stubbing this one is annoying and its not working yet'
      ux = UserExperience.new
      ux.login
      snap = ux.snap

      result = snap.screenshot

      result.success?.must_equal true
    end
  end

  describe '#view' do
    it 'records a view' do
      skip 'stubbing this one is annoying and its not working yet'
      ux = UserExperience.new
      ux.login
      snap = ux.snap

      result = snap.view

      result.success?.must_equal true
    end
  end
end
