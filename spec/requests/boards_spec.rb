require 'swagger_helper'

describe 'Boards API' do
  path '/boards' do
    get 'Retrieves all boards' do
      tags 'Boards'
      security [bearerAuth: []]
      produces 'application/json'
      consumes 'application/json'
      response '200', 'boards found' do
        schema type: :object,
          properties: {
            body: {
              type: :string,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  type: { type: :string },
                  attributes: {
                    type: :object,
                    properties: {
                      title: { type: :string }
                    }
                  }
                }
              }
            }
          }

        run_test!
      end

      response '401', 'unauthorized' do
        run_test!
      end
    end
  end
end