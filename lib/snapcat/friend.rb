module Snapcat
  class Friend
    ALLOWED_FIELD_CONVERSIONS = {
      can_see_custom_stories: :can_see_custom_stories,
      display: :display_name,
      name: :username,
      type: :type
    }

    attr_reader *ALLOWED_FIELD_CONVERSIONS.values

    def initialize(client, username, data = {})
      ALLOWED_FIELD_CONVERSIONS.each do |api_field, human_field|
        # If there's a conflict, the human field overrides the api field
        instance_variable_set(
          "@#{human_field}",
          data[human_field] || data[api_field]
        )
      end

      @client = client
      @username = username
      @type = Type.new(@type)
    end

    def delete
      @client.request_with_username(
        'friend',
        action: 'delete',
        friend: @username
      )
    end

    def set_display_name(display_name)
      @client.request_with_username(
        'friend',
        action: 'display',
        display: display_name,
        friend: @username
      )
    end

    private

    class Type
      CONFIRMED = 0
      UNCONFIRMED = 1
      BLOCKED = 2
      DELETED = 3

      def initialize(code)
        @code = code
      end

      def blocked?
        @code == BLOCKED
      end

      def confirmed?
        @code == CONFIRMED
      end

      def deleted?
        @code == DELETED
      end

      def unconfirmed?
        @code == UNCONFIRMED
      end
    end
  end
end
