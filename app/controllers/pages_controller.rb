class PagesController < ApplicationController
  def show
    @page = Page.find_by(permalink: params[:permalink])

    redirect_to root_path if @page.nil?
  end
end
