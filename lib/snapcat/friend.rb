module Snapcat
  class Friend
    ALLOWED_FIELD_CONVERSIONS = {
      can_see_custom_stories: :can_see_custom_stories,
      display: :display_name,
      name: :username,
      type: :type
    }

    attr_reader *ALLOWED_FIELD_CONVERSIONS.values

    def initialize(data = {})
      ALLOWED_FIELD_CONVERSIONS.each do |api_field, human_field|
        # If there's a conflict, the human field overrides the api field
        instance_variable_set(
          "@#{human_field}",
          data[human_field] || data[api_field]
        )
      end

      @type = Type.new(@type)
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
