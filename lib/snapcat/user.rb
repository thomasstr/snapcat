module Snapcat
  class User
    module Privacy
      EVERYONE = 0
      FRIENDS = 1
    end

    attr_reader :friends, :snaps_sent, :snaps_received, :updates

    def initialize(username)
      @client = Client.new(username)
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

      set_friends(result['friends'])

      set_snaps(result['snaps'])

      @updates = result
    end

    def login(password)
      result = @client.request_with_username('login', password: password)
      !!result['logged']
    end

    def logout
      result = @client.request_with_username('logout')
      result['content'].nil?
    end

    def register(birthday, email, password)
      result = @client.request(
        'register',
        birthday: birthday,
        email: email,
        password: password
      )
      unless result['token']
        return false
      end

      @client.request_with_username(
        'registeru',
        email: email
      )
    end

    def unblock(username)
      @client.request_with_username(
        'friend',
        action: 'unblock',
        friend: username
      )
    end

    def update_email(email)
      @client.request_with_username(
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
        @friends << Friend.new(data: friend, client: @client)
      end
    end

    def set_snaps(snaps)
      @snaps_received = []
      @snaps_sent = []

      snaps.each do |snap|
        if snap['c_id']
          @snaps_sent << Snap.new(snap[:id], data: snap, client: @client)
        else
          @snaps_received << Snap.new(snap[:id], data: snap, client: @client)
        end
      end
    end
  end
end
