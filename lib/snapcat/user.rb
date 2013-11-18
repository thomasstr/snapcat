module Snapcat
  class User
    module Privacy
      EVERYONE = 0
      FRIENDS = 1
    end

    attr_reader :data, :friends, :snaps_sent, :snaps_received

    def initialize(client)
      @client = client
      @friends = []
      @snaps_sent = []
      @snaps_received = []
    end

    def block(username)
      @client.request_with_username(
        'friend',
        action: 'block',
        friend: username
      )
    end

    def clear_feed
      @client.request_with_username('clear')
    end

    def fetch_updates(update_timestamp = 0)
      result = @client.request_with_username(
        'updates',
        update_timestamp: update_timestamp
      )

      set_updates(result)
      result
    end

    def login(password)
      result = @client.request_with_username('login', password: password)

      set_updates(result)
      result
    end

    def logout
      @client.request_with_username('logout')
    end

    def register(birthday, email, password)
      result = @client.request(
        'register',
        birthday: birthday,
        email: email,
        password: password
      )
      unless result.success?
        return result
      end

      result_two = @client.request_with_username(
        'registeru',
        email: email
      )

      set_updates(result_two)
      result_two
    end

    def send_snap(media_id, recipients, view_duration = 3)
      @client.request_with_username(
        'send',
        media_id: media_id,
        recipient: recipients.join(','),
        time: view_duration
      )
    end

    def unblock(username)
      @client.request_with_username(
        'friend',
        action: 'unblock',
        friend: username
      )
    end

    def upload(data, type = nil)
      encrypted_data = Crypt.encrypt(data)

      unless type
        media = Media.new(encrypted_data)

        if media.image?
          type = MediaType::IMAGE
        else
          type = MediaType::VIDEO
        end
      end

      @client.request_upload(encrypted_data, type)
    end

    def update_email(email)
      @client.request_with_username(
        'settings',
        action: 'updateEmail',
        email: email
      )
    end

    def update_privacy(code)
      @client.request_with_username(
        'settings',
        action: 'updatePrivacy',
        privacySetting: code
      )
    end

    private

    def set_friends(friends)
      @friends = []

      friends.each do |friend|
        @friends << Friend.new(@client, friend[:name], friend)
      end
    end

    def set_snaps(snaps)
      @snaps_received = []
      @snaps_sent = []

      snaps.each do |snap|
        snap = Snap.new(@client, snap[:id], snap)
        if snap.sent?
          @snaps_sent << snap
        else
          @snaps_received << snap
        end
      end
    end

    def set_updates(result)
      if result.success?
        set_friends(result.data[:friends])
        set_snaps(result.data[:snaps])
        @data = result.data
      end
    end
  end
end
