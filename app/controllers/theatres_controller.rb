class TheatresController < ApplicationController
  def index
    @theatres = Theatre.all
  end

  def show
    @theatre = Theatre.find(params[:id])
  end
end
