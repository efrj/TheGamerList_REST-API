class Api::V1::GenresController < ApplicationController
  skip_before_action :authenticate_request!, only: [:index, :show]
  before_action :set_genre, only: %i[ show update destroy ]

  # GET /api/v1/genres
  def index
    @genres = Genre.all

    render json: @genres
  end

  # GET /api/v1/genres/1
  def show
    render json: @genre
  end

  # POST /api/v1/genres
  def create
    @genre = Genre.new(genre_params)

    if params[:image].present?
      @genre.image.attach(params[:image])

      thumbnail = ImageProcessingService.create_thumbnail(params[:image], width: 150, height: 100)
      @genre.thumbnail.attach(io: File.open(thumbnail.path), filename: "thumbnail_#{params[:image].original_filename}", content_type: params[:image].content_type)
    end

    if @genre.save
      render json: @genre, serializer: GenreSerializer
    else
      render json: @genre.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/genres/1
  def update
    if @genre.update(genre_params)
      render json: @genre
    else
      render json: @genre.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/genres/1
  def destroy
    @genre.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre
      @genre = Genre.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def genre_params
      params.permit(:name)
    end

    def set_default_url_options
      Rails.application.routes.default_url_options[:host] = ENV['HOST']
      Rails.application.routes.default_url_options[:port] = ENV['PORT']
    end
end
