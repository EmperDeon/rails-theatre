class IndexController < ApplicationController
	def index
		@posters = Poster::closest(4)
		@articles = Article::closest(4)
	end
end
