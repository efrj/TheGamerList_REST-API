class Api::V1::ContentsController < ApplicationController
  skip_before_action :authenticate_request!, only: [:index, :show]
  before_action :set_api_v1_content, only: %i[ show update destroy ]

  # GET /api/v1/contents
  def index
    @api_v1_contents = Api::V1::Content.all

    render json: @api_v1_contents
  end

  # GET /api/v1/contents/1
  def show
    render json: @api_v1_content
  end

  # POST /api/v1/contents
  def create
    @api_v1_content = Api::V1::Content.new(api_v1_content_params)

    if @api_v1_content.save
      render json: @api_v1_content, status: :created, location: @api_v1_content
    else
      render json: @api_v1_content.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/contents/1
  def update
    if @api_v1_content.update(api_v1_content_params)
      render json: @api_v1_content
    else
      render json: @api_v1_content.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/contents/1
  def destroy
    @api_v1_content.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_content
      @api_v1_content = Api::V1::Content.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_content_params
      params.fetch(:api_v1_content, {})
    end
end
