class Columns::ColumnPresenter
    attr_reader :errors

    def call(column_id)
        @errors = []
        @column = load_column(column_id)
        check_column(@column)

        self
    end

    def check_column(column)
        @errors << "column could not be found in DB" unless column.present?
    end

    def load_column(column_id)
        @errors << "missing column id" unless column_id.present?
        return unless successful?
        Column.find_by(id: column_id)
    end

    def render
        {
            id: @column.id,
            title: @column.title,
            position: @column.position
        }
    end

    def successful?
        @errors.blank?
    end

  end