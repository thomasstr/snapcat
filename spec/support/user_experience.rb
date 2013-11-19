class UserExperience
  BIRTHDAY = '1990-01-30'
  EMAIL = 'meow@meow.com'
  FRIEND_DISPLAY_NAME = 'Henrie McKitten'
  FRIEND_USERNAME = 'catsaregreat'
  MEDIA_ID = 'ILUVKITTENS4~1384804683'
  MEDIA_TYPE = Snapcat::MediaType::IMAGE
  PASSWORD = 'topsecret'
  RECIPIENT = 'ronnie99'
  RECIPIENTS = %w(ronnie99 jimbo2000)
  SNAP_ID = '519861384740350100r'
  USERNAME = 'iluvkittens'
  VIEW_DURATION = 6

  attr_reader :client, :user

  def initialize
    @client = Snapcat::Client.new(USERNAME)
    @user = @client.user
  end

  def friend
    @user.friends.find { |friend| friend.username == FRIEND_USERNAME }
  end

  def login
    @client.login(PASSWORD)
  end

  def snap
    @user.snaps_received.first
  end
end
