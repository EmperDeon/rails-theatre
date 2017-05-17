class Favorite < ApplicationRecord
	#
	# Relations
	#
	belongs_to :u_web, class_name: 'User'
	belongs_to :t_perf, class_name: 'TPerformance'


	#
	# Validations
	#
	validate :check_uniqueness

	private
	def check_uniqueness
		p = Favorite.where('t_perf_id = ? AND u_web_id = ?', t_perf_id, u_web_id)
		if p.count > 0
			errors.add(:t_perf_id, ' needs to be unique')
		end
	end
end
