class Api::V1::ReadsController < ApplicationController
  def create
    link = Link.find_or_create_by(url: params[:url])
    read = link.reads.new
    if read.save
      render json: link, status: 201
    else
      render json: link.errors.full_messages.join(", "), status: 500
    end
  end
end
