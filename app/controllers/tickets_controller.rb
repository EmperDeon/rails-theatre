class TicketsController < ApplicationController
	# before_action :authenticate_user!

	def buy_form
		@hall = Poster.find(params[:id]).t_perf.t_hall

		json = JSON::parse(@hall.json)
		db_seats = ActiveRecord::Base.connection.execute('SELECT seat, price FROM seats WHERE poster_id = ' + params[:id])

		@sectors = TicketsHelper::get_sectors json, db_seats

		@prices = @sectors[:prices]
		@sectors = @sectors[:sectors]
	end

	#
	# status:
	#  0 - Error - Show error
	#  1 - No error, user not authenticated - Show save ticket to account dialog
	#  2 - No error, ticket added to user - Show save pdf dialog
	def buy
		poster = params[:id]
		seat = params[:seat]

		@status = 0
		@error = ''

		seat = Seat.where(poster_id: poster, seat: seat)

		if seat.count > 0
			seat = seat[0]

			if seat.sell
				@status = 0
				@error = 'Место уже забронировано/продано.'
			else
				seat.update(sell: 1)

				@status = 1
			end

		else
			@status = 0
			@error = 'Внутренняя ошибка сервера. Место не найдено.'
		end

		if @status == 1 && user_signed_in?
			Ticket.create(u_web: current_user, poster_id: poster)

			@status = 2
		end
	end
end
