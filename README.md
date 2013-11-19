Snapcat
=======

A cat-tastic Ruby wrapper for the [Snapchat](http://snapchat.com) private API.
Meow. This gem is designed to give you a friendly Ruby-like interface for
interacting with the Snapchat API.


Installation
------------

Add this line to your application's `Gemfile`:

    gem 'snapcat', '0.0.1'

And then execute:

    $ bundle

Alternatively, install it via command line:

    $ gem install snapcat


Usage
-----

**User Auth**

```ruby
# Initialize a client and login
client = Snapchat::Client.new('your-username')
client.login('topsecretpassword')

# Initialize a new user, register, and login
client = Snapchat::Client.new('your-new-username')
client.register('topsecretpassword', '1990-01-20', 'test@example.com')

# Logout
client.logout
```


**User Actions**

```ruby
# Block a user
client.block('username-to-block')

# Clear feed
client.clear_feed

# Fetch a user's updates
client.fetch_updates

# Unblock a user
client.unblock('username-to-unlock')

# Update user's email
client.update_email('newemail@example.com')

# Update user's privacy setting
# Two choices:
#   Snapcat::User::Privacy::EVERYONE
#   Snapcat::User::Privacy::FRIENDS
client.update_privacy(Snapcat::User::Privacy::EVERYONE)
```

**User Data**

```ruby
# Get the user
user = client.user

# Examine all raw user data
user.data

# Examine snaps received
user.snaps_received

# Examine snaps sent
user.snaps_sent

# Examine friends
user.friends
```

**Friends**

```ruby
# Grab a friend
friend = user.friends.first

# Set a friend's display name
client.set_display_name(friend.username, 'Nik Ro')

# Delete a friend :(
client.delete_friend(friend.username)

# Learn more about your friend
friend.can_see_custom_stories
friend.display_name
friend.username

# What kind of friend are they anyway??
friend.type
friend.type.confirmed?
friend.type.unconfirmed?
friend.type.blocked?
friend.type.deleted?
```


**Received Snaps**

```ruby
# Grab a snap
snap = user.snaps_received.first

# Get the snap image or video data
media = client.media_for(snap.id)

#Learn more about the media
media.image?
media.valid?
media.video?

# Record a screenshot taken of the snap
client.screenshot(snap.id)

# Record the snap being viewed
client.view(snap.id)
```

**Sending Snaps**

```ruby
# Send it to catsaregreat with 4 seconds duration
# `data` is a string which can be read directly from an mp4 or jpg
client.send_media(data, 'catsaregreat', view_duration: 4)

# Or send it to multiple recipients
client.send_media(data, ['catsaregreat', 'ronnie99'], view_duration: 4)
end
```

**Snaps General**

```ruby
# Learn more about the snap
snap.broadcast
snap.broadcast_action_text
snap.broadcast_hide_timer
snap.broadcast_url
snap.screenshot_count
snap.media_id
snap.id
snap.media_type
snap.recipient
snap.sender
snap.status
snap.sent
snap.opened
```


Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Add tests and make sure they pass
6. Create new Pull Request


Credits
-------

* [Neal Kemp](http://nealke.mp)
* Based on work by martinp on [pysnap](https://github.com/martinp/pysnap) and by
  djstelles on [php-snapchat](https://github.com/dstelljes/php-snapchat)

Copyright &copy; 2013 Neal Kemp

Released under the MIT License, which can be found in the repository in `LICENSE.txt`.
