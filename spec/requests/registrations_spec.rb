require 'swagger_helper'

RSpec.describe 'registrations', type: :request do

  path '/registration' do
    post 'new registration' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, default: 'default@email.com' },
              password: { type: :string, default: '12345678' }
            }
          }
        },
        required: [ 'email', 'password' ]
      }

      response '200', 'user registered' do
        let(:blog) { { title: 'foo', content: 'bar' } }
        run_test!
      end
  
      response '400', 'bad request' do
        let(:blog) { { title: 'foo' } }
        run_test!
      end
    end
  end
end
