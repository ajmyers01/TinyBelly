class LinksController < ApplicationController
  skip_before_action :authorized, only: [:show]

  def index
    @links = @user.links
    render json: {links: @links}
  end

  def create
    @link = Link.new(link_params)
    @link.generate_random_slug! unless @link.slug.present? 
    @link.user_id = @user.id

    if @link.save
      render json: { link: @link }
    else
      render json: { message: @link.errors }
    end

  end

  def destroy
    @link = @user.links.find_by_id(params[:id])

    if @link.present? && @link.destroy
      render json: { message: "Link deleted" }
    else
      render json: { message: "Link was not deleted" }
    end
  end

  def show
    @link = Link.find_by_slug(params[:slug]) 

    if @link.nil?
      # You would redirect to a frontend or a 404 page here instead.
      render json: { message: "No Link Found", status: 404 }
    else
      redirect_to @link.original_url
    end

  end

  private

  def link_params
    params.permit(:original_url, :slug)
  end
end