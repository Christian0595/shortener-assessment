class Api::LinksController < Api::BaseController
  before_action :find_url_by_code, only: [:show, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show]
  # Gets current user from devise and return his links
  def index
    render jsonapi: current_user.links
  end

  def create
    link = current_user.links.create(create_params)
    json_response link
  end

  def show
    redirect_to @link.url
  end

  private

  def create_params
    params.require(:link).permit(:url)
  end

  def find_url_by_code
    @link = Link.find_by_code!(params[:id])
    save_visit
  end

  def save_visit
    ::RequestProcessor.new(request, @link).process
  end
end
