class User < ApplicationRecord
	self.table_name = 'u_webs' # Because i want /users/ in URL

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :rememberable, :validatable

	#
	# FIX for Devise
	# When key name in table changed to anything but 'email', these functions needed for ':validatable'
	def email_required?
		false
	end

	def email_changed?
		false
	end


end
