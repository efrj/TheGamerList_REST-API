require 'swagger_helper'

RSpec.describe 'api/v1/platforms', type: :request do
  path '/api/v1/platforms' do
    get('Lista todas as plataformas') do
      tags 'Platforms'
      produces 'application/json'
      
      response(200, 'successful') do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              description: { type: :string },
              release_year: { type: :integer },
              generation_id: { type: :integer },
              created_at: { type: :string, format: :datetime },
              updated_at: { type: :string, format: :datetime }
            }
          }

        run_test!
      end
    end

    post('Cria uma nova plataforma') do
      tags 'Platforms'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :platform, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          release_year: { type: :integer },
          generation_id: { type: :integer }
        },
        required: ['name', 'generation_id']
      }

      response(201, 'created') do
        let(:platform) { { name: 'New Platform', generation_id: 1 } }
        run_test!
      end
    end
  end

  path '/api/v1/platforms/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'ID da plataforma'

    get('Mostra uma plataforma específica') do
      tags 'Platforms'
      produces 'application/json'
      
      response(200, 'successful') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            release_year: { type: :integer },
            generation_id: { type: :integer },
            created_at: { type: :string, format: :datetime },
            updated_at: { type: :string, format: :datetime }
          }

        let(:id) { '1' }
        run_test!
      end
    end

    put('Atualiza uma plataforma') do
      tags 'Platforms'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :platform, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          release_year: { type: :integer }
        }
      }

      response(200, 'successful') do
        let(:id) { '1' }
        let(:platform) { { name: 'Updated Platform' } }
        run_test!
      end
    end

    delete('Remove uma plataforma') do
      tags 'Platforms'
      produces 'application/json'
      
      response(204, 'no content') do
        let(:id) { '1' }
        run_test!
      end
    end
  end
end
