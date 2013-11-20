require 'spec_helper'

describe Snapcat::Snap do
  describe '.new' do
    it 'converts fields' do
      snap = Snapcat::Snap.new(snap_data)

      snap.broadcast.must_equal snap_data[:broadcast]
      snap.broadcast_action_text.must_equal snap_data[:broadcast_action_text]
      snap.broadcast_hide_timer.must_equal snap_data[:broadcast_hide_timer]
      snap.broadcast_url.must_equal snap_data[:broadcast_url]
      snap.screenshot_count.must_equal snap_data[:c]
      snap.media_id.must_equal snap_data[:c_id]
      snap.id.must_equal snap_data[:id]
      snap.media_type.code.must_equal snap_data[:m]
      snap.recipient.must_equal snap_data[:rp]
      snap.sender.must_equal snap_data[:sn]
      snap.sent.must_equal snap_data[:sts]
      snap.opened.must_equal snap_data[:ts]
    end

    it 'sets status to value object' do
      snap = Snapcat::Snap.new(snap_data)

      snap.status.code.must_equal snap_data[:st]
      snap.status.delivered?.must_equal true
      snap.status.none?.must_equal false
    end
  end

  def snap_data
    {
      id: '519861384740350100r',
      sn: 'ronnie99',
      t: 6,
      ts: 1384740350062,
      sts: 1384740350062,
      m: 0,
      st: 1,
      # These fields weren't found on general requests but were noted in other
      # snapchat libraries
      broadcast: 'broadcast',
      broadcast_action_text: 'broadcast_action_text',
      broadcast_hide_timer: 'broadcast_hide_timer',
      broadcast_url: 'broadcast_url',
      c: 'c',
      c_id: 'c_id',
      rp: 'jimmy10'
    }
  end
end
