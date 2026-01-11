class Api::V1::SofthousesController < ApplicationController
  skip_before_action :authenticate_request!, only: [:index, :show]
  before_action :set_api_v1_softhouse, only: %i[ show update destroy ]

  # GET /api/v1/softhouses
  def index
    @api_v1_softhouses = Api::V1::Softhouse.all

    render json: @api_v1_softhouses
  end

  # GET /api/v1/softhouses/1
  def show
    render json: @api_v1_softhouse
  end

  # POST /api/v1/softhouses
  def create
    @api_v1_softhouse = Api::V1::Softhouse.new(api_v1_softhouse_params)

    if @api_v1_softhouse.save
      render json: @api_v1_softhouse, status: :created, location: @api_v1_softhouse
    else
      render json: @api_v1_softhouse.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/softhouses/1
  def update
    if @api_v1_softhouse.update(api_v1_softhouse_params)
      render json: @api_v1_softhouse
    else
      render json: @api_v1_softhouse.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/softhouses/1
  def destroy
    @api_v1_softhouse.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_softhouse
      @api_v1_softhouse = Api::V1::Softhouse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_softhouse_params
      params.fetch(:api_v1_softhouse, {})
    end
end
