require 'swagger_helper'

RSpec.describe 'api/v1/games', type: :request do
  path '/api/v1/games' do
    get('Lista todos os jogos') do
      tags 'Games'
      produces 'application/json'
      
      response(200, 'successful') do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              title: { type: :string },
              description: { type: :string },
              release_year: { type: :integer },
              video_url: { type: :string, nullable: true },
              genre_id: { type: :integer },
              platform_id: { type: :integer },
              softhouse_id: { type: :integer },
              created_at: { type: :string, format: :datetime },
              updated_at: { type: :string, format: :datetime }
            }
          }

        run_test!
      end
    end

    post('Cria um novo jogo') do
      tags 'Games'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :game, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          release_year: { type: :integer },
          video_url: { type: :string },
          genre_id: { type: :integer },
          platform_id: { type: :integer },
          softhouse_id: { type: :integer }
        },
        required: ['title', 'genre_id', 'platform_id', 'softhouse_id']
      }

      response(201, 'created') do
        let(:game) { { title: 'New Game', genre_id: 1, platform_id: 1, softhouse_id: 1 } }
        run_test!
      end
    end
  end

  path '/api/v1/games/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'ID do jogo'

    get('Mostra um jogo específico') do
      tags 'Games'
      produces 'application/json'
      
      response(200, 'successful') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            description: { type: :string },
            release_year: { type: :integer },
            video_url: { type: :string, nullable: true },
            genre_id: { type: :integer },
            platform_id: { type: :integer },
            softhouse_id: { type: :integer },
            created_at: { type: :string, format: :datetime },
            updated_at: { type: :string, format: :datetime }
          }

        let(:id) { '1' }
        run_test!
      end
    end

    put('Atualiza um jogo') do
      tags 'Games'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :game, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          release_year: { type: :integer },
          video_url: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:id) { '1' }
        let(:game) { { title: 'Updated Game' } }
        run_test!
      end
    end

    delete('Remove um jogo') do
      tags 'Games'
      produces 'application/json'
      
      response(204, 'no content') do
        let(:id) { '1' }
        run_test!
      end
    end
  end
end
