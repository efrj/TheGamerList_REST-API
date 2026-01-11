require 'swagger_helper'

RSpec.describe 'api/v1/generations', type: :request do
  path '/api/v1/generations' do
    get('Lista todas as gerações') do
      tags 'Generations'
      produces 'application/json'
      
      response(200, 'successful') do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              description: { type: :string },
              starting_year: { type: :integer },
              created_at: { type: :string, format: :datetime },
              updated_at: { type: :string, format: :datetime }
            }
          }

        run_test!
      end
    end

    post('Cria uma nova geração') do
      tags 'Generations'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :generation, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          starting_year: { type: :integer }
        },
        required: ['name']
      }

      response(201, 'created') do
        let(:generation) { { name: 'New Generation' } }
        run_test!
      end
    end
  end

  path '/api/v1/generations/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'ID da geração'

    get('Mostra uma geração específica') do
      tags 'Generations'
      produces 'application/json'
      
      response(200, 'successful') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            starting_year: { type: :integer },
            created_at: { type: :string, format: :datetime },
            updated_at: { type: :string, format: :datetime }
          }

        let(:id) { '1' }
        run_test!
      end
    end

    put('Atualiza uma geração') do
      tags 'Generations'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :generation, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          starting_year: { type: :integer }
        }
      }

      response(200, 'successful') do
        let(:id) { '1' }
        let(:generation) { { name: 'Updated Generation' } }
        run_test!
      end
    end

    delete('Remove uma geração') do
      tags 'Generations'
      produces 'application/json'
      
      response(204, 'no content') do
        let(:id) { '1' }
        run_test!
      end
    end
  end
end
