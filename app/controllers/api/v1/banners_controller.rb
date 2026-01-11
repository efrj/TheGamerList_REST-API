class Api::V1::BannersController < ApplicationController
  skip_before_action :authenticate_request!, only: [:index, :show]
  before_action :set_api_v1_banner, only: %i[ show update destroy ]

  # GET /api/v1/banners
  def index
    @api_v1_banners = Api::V1::Banner.all

    render json: @api_v1_banners
  end

  # GET /api/v1/banners/1
  def show
    render json: @api_v1_banner
  end

  # POST /api/v1/banners
  def create
    @api_v1_banner = Api::V1::Banner.new(api_v1_banner_params)

    if @api_v1_banner.save
      render json: @api_v1_banner, status: :created, location: @api_v1_banner
    else
      render json: @api_v1_banner.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/banners/1
  def update
    if @api_v1_banner.update(api_v1_banner_params)
      render json: @api_v1_banner
    else
      render json: @api_v1_banner.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/banners/1
  def destroy
    @api_v1_banner.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_banner
      @api_v1_banner = Api::V1::Banner.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_banner_params
      params.fetch(:api_v1_banner, {})
    end
end
