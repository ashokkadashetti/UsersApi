module Api
	module V1
		class CandidatesController < ApplicationController

			def index
				begin
					candidates = Candidate.order('created_at DESC');
					render json: {status: 'Success', message: 'Loaded candidates list', data:candidates}, status: :ok		
				rescue
					render json: {status: 'Error', message: 'Unable to fetch'}, status: :unprocessable_entity 
				end

			end

#........................................................................................................................................

			def show
				begin
					candidate = Candidate.find(params[:id])
					render json: {status: 'Success', message: 'User found',data:candidate}, status: :ok
				rescue
					render json: {status: 'Error', message: 'User not found for this id'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................

			def create
				candidate = Candidate.new(candidate_params)
				begin
					candidate.save!
					render json: {status: 'Success', message: 'Saved candidate', data:candidate}, status: :ok
				rescue
					render json: {status: 'Error', message: 'Candidate not saved'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................

			def destroy
				begin
					candidate = Candidate.find(params[:id])
					candidate.destroy!
					render json: {status: 'Success', message: 'Deleted candidate', data:candidate}, status: :ok
				rescue
					render json: {status: 'Error', message: 'Project not destroyed'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................

			def update
				begin
					candidate = Candidate.find(params[:id])
						if candidate.update(candidate_params)
							render json: {status: 'Success', message: 'Updated candidate', data:candidate}, status: :ok
						end
				rescue
					render json: {status: 'Error', message: 'Candidate not updated'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................

			private

			def candidate_params
			  params.require(:candidate).permit(:name,:email,:user_id)
			end
		end
	end
end
