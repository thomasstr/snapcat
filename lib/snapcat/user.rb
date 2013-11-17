module Snapcat
  class User
    module Privacy
      EVERYONE = 0
      FRIENDS = 1
    end

    attr_reader :friends, :snaps_sent, :snaps_received, :updates

    def initialize(client)
      @client = client
      @friends = []
      @snaps_sent = []
      @snaps_received = []
    end

    def block(username)
      Client.success? @client.request_with_username(
        'friend',
        action: 'block',
        friend: username
      )
    end

    def clear_feed
      Client.success? @client.request_with_username('clear')
    end

    def fetch_updates(update_timestamp = 0)
      result = @client.request_with_username(
        'updates',
        update_timestamp: update_timestamp
      )

      set_updates(result)
      Client.success?(result)
    end

    def login(password)
      result = @client.request_with_username('login', password: password)

      if Client.success?(result)
        set_updates(result)
        true
      else
        false
      end
    end

    def logout
      result = @client.request_with_username('logout')
      Client.success?(result)
    end

    def register(birthday, email, password)
      result = @client.request(
        'register',
        birthday: birthday,
        email: email,
        password: password
      )
      unless Client.success?(result)
        return false
      end

      result_two = @client.request_with_username(
        'registeru',
        email: email
      )
      Client.success?(result_two)
    end

    def unblock(username)
      Client.success? @client.request_with_username(
        'friend',
        action: 'unblock',
        friend: username
      )
    end

    def username=(new_username)
      @client.username = new_username
    end

    def update_email(email)
      Client.success? @client.request_with_username(
        'settings',
        action: 'updateEmail',
        email: email
      )
    end

    def update_privacy(code)
      Client.success? @client.request_with_username(
        'settings',
        action: 'updatePrivacy',
        privacySetting: code
      )
    end

    private

    def set_friends(friends)
      @friends = []

      friends.each do |friend|
        @friends << Friend.new(@client, friend)
      end
    end

    def set_snaps(snaps)
      @snaps_received = []
      @snaps_sent = []

      snaps.each do |snap|
        if snap['c_id']
          @snaps_sent << Snap.new(@client, snap[:id], snap)
        else
          @snaps_received << Snap.new(@client, snap)
        end
      end
    end

    def set_updates(result)
      set_friends(result[:friends])
      set_snaps(result[:snaps])
      @updates = result
    end
  end
end
