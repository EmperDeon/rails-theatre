class TPerformanceController < ApplicationController
    def index
        @perfs = TPerformance.by_type(params[:type])
                     .by_name(params[:name])
                     .by_theatre(params[:theatre])
                     .order(id: :desc)
    end

    def show
        @perf = TPerformance.find(params[:id])
    end
end
