class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :set_constants

    private
    def set_constants
        @p_types = PType.all
        @theatres = Theatre.all

    end

end
