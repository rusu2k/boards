class Stories::Filter < BaseFilter
    def run(options: {})
        return Story.all if options.blank?

        # by default get stories by board
        result = Story
        result = result.where(board_id: options[:board].id)

        result = result.where(user_id: options[:user_id]) if options.key?(:user_id)
        result = result.where(column_id: options[:column_id]) if options.key?(:column_id)

        result
    end

end