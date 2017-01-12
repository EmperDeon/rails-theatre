class IndexController < ApplicationController
    def index
        @posters = Poster::limit(4)

    end
end
