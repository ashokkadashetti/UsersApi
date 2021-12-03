module Api
	module V1
		class UsersController < ApplicationController

			def index
				begin
					users = User.order('created_at DESC');
					render json: {status: 'Success', message: 'Loaded users', data:users}, status: :ok	
				rescue
					render json: {status: 'Error', message: 'Unavailable'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................

			def show
				begin
					user = User.find(params[:id])
					render json: {status: 'Success', message: 'User shown', data:user}, status: :ok
				rescue
					render json: {status: 'Error', message: 'Unavailable'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................


			def create
				begin
					user = User.new(user_params)

					if user.save
						candidate = Candidate.new(user_id:user.id, name:user.name, email:user.email)
						if candidate.save
							render json: {status: 'Success', message: 'Record saved', data:user}, status: :ok
						end
					end

				rescue
					render json: {status: 'Error', message: 'User not saved'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................


			def destroy
				begin
					user = User.find(params[:id])
					user.destroy
					render json: {status: 'Success', message: 'Deleted user', data:user}, status: :ok
				rescue
					render json: {status: 'Error', message: 'User not destroyed'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................


			def update
				begin
					user = User.find(params[:id])
					if user.update(user_params)
						render json: {status: 'Success', message: 'Updated user', data:user}, status: :ok
				    end
				rescue
					render json: {status: 'Error', message: 'User not updated'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................


			private

			def user_params
				begin
					params.require(:user).permit(:name,:email,:password,:role,candidates_attributes: [:name, :email])
				rescue
					render json: {status: 'Error', message: 'parameters error'}, status: :unprocessable_entity
				end
			end
		end
	end
end