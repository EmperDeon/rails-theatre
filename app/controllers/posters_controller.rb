class PostersController < ApplicationController
  def index
    @posters = Poster.by_month(params[:by_month])
                 .by_day(params[:by_day])
                 .by_time(params[:by_time])
                 .by_type(params[:by_type])
                 .by_name(params[:by_name])
                 .by_theatre(params[:by_theatre])
                 .order(date: :asc)
                 .includes(t_perf: [{perf: [:p_type]}, :theatre, :t_hall])
  end
end
