class UserExperience
  BIRTHDAY = '1990-01-30'
  EMAIL = 'meow@meow.com'
  FRIEND_DISPLAY_NAME = 'Henrie McKitten'
  FRIEND_USERNAME = 'catsaregreat'
  IMAGE_DATA = nil
  PASSWORD = 'topsecret'
  SNAP_ID = '519861384740350100r'
  USERNAME = 'iluvkittens'

  attr_reader :client, :user

  def initialize
    @client = Snapcat::Client.new(USERNAME)
    @user = @client.user
  end

  def friend
    @user.friends.find { |friend| friend.username == FRIEND_USERNAME }
  end

  def login
    @user.login(PASSWORD)
  end

  def snap
    @user.snaps_received.first
  end
end
