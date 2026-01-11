class Api::V1::PlatformsInformationsController < ApplicationController
  skip_before_action :authenticate_request!, only: [:index, :show]
  before_action :set_api_v1_platforms_information, only: %i[ show update destroy ]

  # GET /api/v1/platforms_informations
  def index
    @api_v1_platforms_informations = Api::V1::PlatformsInformation.all

    render json: @api_v1_platforms_informations
  end

  # GET /api/v1/platforms_informations/1
  def show
    render json: @api_v1_platforms_information
  end

  # POST /api/v1/platforms_informations
  def create
    @api_v1_platforms_information = Api::V1::PlatformsInformation.new(api_v1_platforms_information_params)

    if @api_v1_platforms_information.save
      render json: @api_v1_platforms_information, status: :created, location: @api_v1_platforms_information
    else
      render json: @api_v1_platforms_information.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/platforms_informations/1
  def update
    if @api_v1_platforms_information.update(api_v1_platforms_information_params)
      render json: @api_v1_platforms_information
    else
      render json: @api_v1_platforms_information.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/platforms_informations/1
  def destroy
    @api_v1_platforms_information.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_platforms_information
      @api_v1_platforms_information = Api::V1::PlatformsInformation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_platforms_information_params
      params.fetch(:api_v1_platforms_information, {})
    end
end
