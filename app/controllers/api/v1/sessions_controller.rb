module Api
	module V1
		class SessionsController < ApplicationController

			def create

				 if (user = User.where(email: params[:email]).first)
				 	#render json: {status: 'Success', message: 'Authorized users'}, status: :ok

					if user.valid_password?(params[:password])
						render json: {status: 'Success', message: 'Authorized user'}, status: :ok
					else
						render json: {status: 'Error', message: 'Wrong password'}, status: :ok
					end

				else
					render json: {status: 'Error', message: 'Email not valid'}, status: :ok
				end



				# if user&.valid_password?(params[:password])
				# 	render json: {status: 'Success', message: 'Authorized users'}, status: :ok
				# else
				# 	render json: {status: 'Error', message: 'Wrong password'}, status: :ok
				# end
				#end


			end

			def destroy

			end

		end
	end
end
