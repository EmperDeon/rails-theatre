class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true


	def self.where_time(time)
		q = if Rails.env.production?
			    "DATE_FORMAT(date, '%H:%i')"
			else
				"strftime('%H:%M', date)"
		    end
		q += ' = ?'

		where(q, UtilsHelper.get_hash('time')[time.to_i])
	end

	def self.where_day_of_week (day)
		q = if Rails.env.production?
			    'DAYOFWEEK(date)'
			else
				day = day.to_i - 1
				"strftime('%w', date)"
		    end
		q += ' = ?'

		where(q, day.to_s)
	end

	def self.where_month (month)
		q = if Rails.env.production?
			    'MONTH(date)'
			else
				"strftime('%m', date)"
		    end
		q += ' = ?'

		where(q, month)
	end

end
