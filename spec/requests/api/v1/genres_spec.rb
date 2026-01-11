require 'swagger_helper'

RSpec.describe 'api/v1/genres', type: :request do
  path '/api/v1/genres' do
    get('Lista todos os gêneros') do
      tags 'Genres'
      produces 'application/json'
      
      response(200, 'successful') do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              created_at: { type: :string, format: :datetime },
              updated_at: { type: :string, format: :datetime }
            }
          }

        run_test!
      end
    end

    post('Cria um novo gênero') do
      tags 'Genres'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :genre, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response(201, 'created') do
        let(:genre) { { name: 'New Genre' } }
        run_test!
      end
    end
  end

  path '/api/v1/genres/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'ID do gênero'

    get('Mostra um gênero específico') do
      tags 'Genres'
      produces 'application/json'
      
      response(200, 'successful') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            created_at: { type: :string, format: :datetime },
            updated_at: { type: :string, format: :datetime }
          }

        let(:id) { '1' }
        run_test!
      end
    end

    put('Atualiza um gênero') do
      tags 'Genres'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :genre, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:id) { '1' }
        let(:genre) { { name: 'Updated Genre' } }
        run_test!
      end
    end

    delete('Remove um gênero') do
      tags 'Genres'
      produces 'application/json'
      
      response(204, 'no content') do
        let(:id) { '1' }
        run_test!
      end
    end
  end
end
