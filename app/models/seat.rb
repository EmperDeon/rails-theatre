class Seat < ApplicationRecord
	#
	# Relations
	#
	belongs_to :poster

	#
	# Scopes
	#
	scope :not_sell, -> { where(sell: 0) }
	scope :by_poster, -> (p) { where(poster: p) if p }
end
