class LinksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :find_url_by_code, only: [:show]
  before_action :find_user_urls_by_code, only: [:update, :destroy]

  # Gets current user from devise and return his links
  def index
    render jsonapi: current_user.links
  end

  def create
    link = current_user.links.create(link_params)
    json_response link
  end

  def show
    save_visit
    redirect_to @link.url
  end

  def update
    @link.update(link_params)
    json_response @link
  end

  def destroy
    @link.delete
    json_response @link
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def find_url_by_code
    @link = Link.find_by_code!(params[:id])
  end

  def find_user_urls_by_code
    @link = current_user.links.find_by_code!(params[:id])
  end

  def save_visit
    ::RequestProcessor.new(request, @link).process
  end
end
