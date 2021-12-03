module Api
	module V1
		class UsersController < ApplicationController

			def index
				users = User.order('created_at DESC');
				render json: {status: 'Success', message: 'Loaded users', data:users}, status: :ok		
			end

			def show
				user = User.find(params[:id])
				render json: {status: 'Success', message: 'Loaded user', data:user}, status: :ok
			end

			def create
				user = User.new(user_params)

				if user.save
					#@suser = user
					candidate = Candidate.new(user_id:user.id, name:user.name, email:user.email)
					if candidate.save
						render json: {status: 'Success', message: 'Record saved', data:user}, status: :ok
					else
						render json: {status: 'Error', message: 'User not saved', data:user.error}, status: :unprocessable_entity
					end
				end

			end

			def destroy
				user = User.find(params[:id])
				user.destroy
				render json: {status: 'Success', message: 'Deleted user', data:user}, status: :ok
			end

			def update
				user = User.find(params[:id])
				if user.update(user_params)
					render json: {status: 'Success', message: 'Updated user', data:user}, status: :ok
				else
					render json: {status: 'Error', message: 'User not updated', data:user.error}, status: :unprocessable_entity
				end

			end

			private

			def user_params
				params.require(:user).permit(:name,:email,:password,:role,candidates_attributes: [:name, :email])
			end
		end
	end
end