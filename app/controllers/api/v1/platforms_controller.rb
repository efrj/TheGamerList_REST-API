class Api::V1::PlatformsController < ApplicationController
  skip_before_action :authenticate_request!, only: [:index, :show]
  before_action :set_api_v1_platform, only: %i[ show update destroy ]

  # GET /api/v1/platforms
  def index
    @api_v1_platforms = Api::V1::Platform.all

    render json: @api_v1_platforms
  end

  # GET /api/v1/platforms/1
  def show
    render json: @api_v1_platform
  end

  # POST /api/v1/platforms
  def create
    @api_v1_platform = Api::V1::Platform.new(api_v1_platform_params)

    if @api_v1_platform.save
      render json: @api_v1_platform, status: :created, location: @api_v1_platform
    else
      render json: @api_v1_platform.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/platforms/1
  def update
    if @api_v1_platform.update(api_v1_platform_params)
      render json: @api_v1_platform
    else
      render json: @api_v1_platform.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/platforms/1
  def destroy
    @api_v1_platform.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_platform
      @api_v1_platform = Api::V1::Platform.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_platform_params
      params.fetch(:api_v1_platform, {})
    end
end
