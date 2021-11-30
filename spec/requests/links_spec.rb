require 'swagger_helper'

RSpec.describe 'links', type: :request do

  path '/links' do

    get 'list links' do
      tags 'Links'
      produces 'application/json'
      security [ bearerAuth: [] ]

      response '200', 'listed links' do
        let(:blog) { { title: 'foo', content: 'bar' } }
        run_test!
      end

      response '401', 'unauthorized user' do
        let(:blog) { { title: 'foo', content: 'bar' } }
        run_test!
      end
    end

    post 'create link' do
      tags 'Links'
      produces 'application/json'
      security [ bearerAuth: [] ]
      consumes 'application/json'
      parameter name: :link, in: :body, schema: {
        type: :object,
        properties: {
          link: {
            type: :object,
            properties: {
              url: { type: :string, default: 'www.google.com.mx' },
            }
          }
        },
        required: [ 'url' ]
      }

      response '200', 'link registered' do
        let(:blog) { { title: 'foo', content: 'bar' } }
        run_test!
      end

      response '400', 'bad request' do
        let(:blog) { { title: 'foo', content: 'bar' } }
        run_test!
      end
    end
  end

  path '/links/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
   
    put 'update link' do
      tags 'Links'
      produces 'application/json'
      security [ bearerAuth: [] ]
      consumes 'application/json'
      parameter name: :link, in: :body, schema: {
        type: :object,
        properties: {
          link: {
            type: :object,
            properties: {
              url: { type: :string, default: 'www.google.com.mx' },
            }
          }
        },
        required: [ 'url' ]
      }

      response '200', 'link registered' do
        let(:blog) { { title: 'foo', content: 'bar' } }
        run_test!
      end

      response '400', 'bad request' do
        let(:blog) { { title: 'foo', content: 'bar' } }
        run_test!
      end

      response '404', 'not found' do
        let(:blog) { { title: 'foo', content: 'bar' } }
        run_test!
      end
    end

    delete 'delete link' do
      tags 'Links'
      produces 'application/json'
      security [ bearerAuth: [] ]
      consumes 'application/json'

      response '200', 'link deleted' do
        let(:blog) { { title: 'foo', content: 'bar' } }
        run_test!
      end

      response '404', 'not found' do
        let(:blog) { { title: 'foo', content: 'bar' } }
        run_test!
      end
    end
  end
end
