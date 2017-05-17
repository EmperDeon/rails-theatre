module Auth
	class RegisterController < Devise::RegistrationsController

		#
		# Fix for Devise
		#  After adding fields to User model, you need to insert in there too
		private
		def sign_up_params
			params.require(:user).permit(:login, :password, :password_confirmation, :fio, :tel_num)
		end

		def account_update_params
			params.require(:user).permit(:login, :password, :password_confirmation, :current_password, :fio, :tel_num)
		end
	end
end
