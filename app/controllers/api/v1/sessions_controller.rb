module Api
	module V1
		class SessionsController < ApplicationController

			def create
				 if (user = User.where(email: params[:email]).first)
					if user.valid_password?(params[:password])
						render json: {status: 'Success', message: 'Authorized user'}, status: :ok
					else
						render json: {status: 'Error', message: 'Wrong password'}, status: :unprocessable_entity
					end
				else
					render json: {status: 'Error', message: 'Email not valid'}, status: :unprocessable_entity
				end
			end

#...................................................................................................................

			def destroy

			end

		end
	end
end
