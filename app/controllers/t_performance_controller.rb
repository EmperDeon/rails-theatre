class TPerformanceController < ApplicationController
    def index
        @perfs = TPerformance.by_type(params[:by_type])
                     .by_name(params[:by_name])
                     .by_theatre(params[:by_theatre])
                     .order(id: :desc)
    end

    def show
        @perf = TPerformance.find(params[:id])
    end
end
