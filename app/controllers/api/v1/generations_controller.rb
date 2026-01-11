class Api::V1::GenerationsController < ApplicationController
  skip_before_action :authenticate_request!, only: [:index, :show]
  before_action :set_api_v1_generation, only: %i[ show update destroy ]

  # GET /api/v1/generations
  def index
    @api_v1_generations = Api::V1::Generation.all

    render json: @api_v1_generations
  end

  # GET /api/v1/generations/1
  def show
    render json: @api_v1_generation
  end

  # POST /api/v1/generations
  def create
    @api_v1_generation = Api::V1::Generation.new(api_v1_generation_params)

    if @api_v1_generation.save
      render json: @api_v1_generation, status: :created, location: @api_v1_generation
    else
      render json: @api_v1_generation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/generations/1
  def update
    if @api_v1_generation.update(api_v1_generation_params)
      render json: @api_v1_generation
    else
      render json: @api_v1_generation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/generations/1
  def destroy
    @api_v1_generation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_generation
      @api_v1_generation = Api::V1::Generation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_generation_params
      params.fetch(:api_v1_generation, {})
    end
end
