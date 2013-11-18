module Snapcat
  class Snap
    ALLOWED_FIELD_CONVERSIONS = {
      broadcast: :broadcast,
      broadcast_action_text: :broadcast_action_text,
      broadcast_hide_timer: :broadcast_hide_timer,
      broadcast_url: :broadcast_url,
      c: :screenshot_count,
      c_id: :media_id,
      id: :id,
      m: :media_type,
      rp: :recipient,
      sn: :sender,
      st: :status,
      sts: :sent,
      ts: :opened
    }

    attr_reader *ALLOWED_FIELD_CONVERSIONS.values

    def initialize(client, id, data = {})
      ALLOWED_FIELD_CONVERSIONS.each do |api_field, human_field|
        # Allow user-supplied human field to override api field
        instance_variable_set(
          "@#{human_field}",
          data[human_field] || data[api_field]
        )
      end

      @id = id
      @status = Status.new(@status)
      @media_type = MediaType.new(@media_type)
      @client = client
    end

    def media
      @media ||= get_media
    end

    def received?
      !sent?
    end

    def screenshot(view_duration = 1)
      snap_data = {
        @id => {
          c: Status::SCREENSHOT,
          sv: view_duration,
          t: Timestamp.float
        }
      }
      events = [
        {
          eventName: 'SNAP_SCREENSHOT',
          params: { id: @id },
          ts: Timestamp.macro - view_duration
        }
      ]

      @client.request_events(events, snap_data)
    end

    def sent?
      !!media_id
    end

    def view(view_duration = 1)
      snap_data = {
        @id => { t: Timestamp.float, sv: view_duration }
      }
      events = [
        {
          eventName: 'SNAP_VIEW',
          params: { id: @id },
          ts: Timestamp.macro - view_duration
        },
        {
          eventName: 'SNAP_EXPIRED',
          params: { id: @id },
        }
      ]

      @client.request_events(events, snap_data)
    end

    private

    class Status
      NONE = -1
      SENT = 0
      DELIVERED = 1
      OPENED = 2
      SCREENSHOT = 3

      attr_reader :code

      def initialize(code)
        @code = code
      end

      def delivered?
        @code == DELIVERED
      end

      def opened?
        @code == OPENED
      end

      def sent?
        @code == SENT
      end

      def screenshot?
        @code == SCREENSHOT
      end

      def none?
        @code == NONE
      end
    end

    def get_media
      result = @client.request_media(@id)
      Snapcat::Media.new(result)
    end
  end
end
