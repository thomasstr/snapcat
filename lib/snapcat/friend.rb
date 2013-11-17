module Snapcat
  class Friend
    ALLOWED_FIELD_CONVERSIONS = {
      can_see_custom_stories: :can_see_custom_stories,
      display: :display_name,
      name: :username,
      type: :type
    }

    attr_friend *ALLOWED_FIELD_CONVERSIONS.values

    def initialize(options = {})
      ALLOWED_FIELD_CONVERSIONS.each do |api_field, human_field|
        instance_variable_set("@#{human_field}", options[:data][api_field])
        # Allow user-supplied human field to override api field
        instance_variable_set("@#{human_field}", options[:data][human_field])
      end

      @client = options[:client]
      @type = Type.new(@type)
    end

    def delete
      @client.request_with_username('delete', friend: @name)
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
