module Api
	module V1
		class ProjectsController < ApplicationController

			def index
				begin
				projects = Project.order('created_at DESC');
				render json: {status: 'Success', message: 'Loaded project', data:projects}, status: :ok		
				rescue
					render json: {status: 'Error', message: 'Project not loaded'}, status: :unprocessable_entity 
				end

			end

#........................................................................................................................................

			def show
				begin
				project = Project.find(params[:id])
				render json: {status: 'Success', message: 'User found',data:project}, status: :ok
				rescue
					render json: {status: 'Error', message: 'User not found for this id'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................

			def create
				project = Project.new(project_params)
				begin
					if project.save
						render json: {status: 'Success', message: 'Saved project', data:project}, status: :ok
					# else
					# 	render json: {status: 'Error', message: 'Project not saved', data:project.error}, status: :unprocessable_entity
					end
				rescue
					render json: {status: 'Error', message: 'Project not saved'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................

			def destroy
				begin
				project = Project.find(params[:id])
				project.destroy!
				render json: {status: 'Success', message: 'Deleted project', data:project}, status: :ok
				rescue
					render json: {status: 'Error', message: 'Project not destroyed'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................

			def update
				begin
				project = Project.find(params[:id])
					if project.update(project_params)
						render json: {status: 'Success', message: 'Updated project', data:project}, status: :ok
					# else
					# 	render json: {status: 'Error', message: 'Project not updated', data:project.error}, status: :unprocessable_entity
					end
				rescue
					render json: {status: 'Error', message: 'Project not updated'}, status: :unprocessable_entity
				end
			end

#........................................................................................................................................

			private

			def project_params
				begin
				params.permit(:name,:description,:idle,:realtime,:bill)
			 	rescue
			 	render json: {status: 'Error', message: 'Record not found'}, status: :ok
			    end

			end

		end

	end

end