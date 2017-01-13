class PosterController < ApplicationController
    def index
        @posters = Poster.by_month(params[:month])
                       .by_day(params[:day])
                       .by_time(params[:time])
                       .by_type(params[:type])
                       .by_name(params[:name])
                       .by_theatre(params[:theatre])
                       .order(date: :asc)
                       .includes(:t_perf, :t_hall)
    end
end
