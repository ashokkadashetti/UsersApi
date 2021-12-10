# frozen_string_literal: true

module Api
  module V1
    # class
    class UsersController < ApplicationController
      def index
        #raise UserNotFoundError.new("user not fount for this id", :index)
        users = User.order('created_at ASC')
        render json: { status: 'Success', message: 'Loaded users', data: users }, status: :ok
      rescue StandardError => e
        render json: { status: 'Error', message: e.message }, status: :unprocessable_entity
      end
      # ...................................................................................

      def show
        user = User.find(params[:id])
        candidates = user.candidates || []
        projects = hash_arr.new
        temp = Array.new
        if (candidates.exists?)
          for i in 0...candidates.size
            temp[i] = candidates[i]
            projects[i] = candidates[i].projects
          end  
        end
        hash = Hash.new
        for i in 0...projects.size
          hash.try_convert(projects[i])
        end


        # projects = candidates.find(candidates.ids)
        # candidate = CandidatesProject.where(candidate_id: candidates.ids)
        # projects = Hash.new
        # for i in 0...candidate.size
          
        #   candidates[i][(Project.where(id: candidate[i].project_id))]
          
        # end
        #projects = Project.where(id: candidate.project_id)
        render json: { status: 'Success', message: 'User found', user: user, data: candidates,project:projects,temp:temp,hash:hash }, status: :ok


        #candidate = Candidate.where(id:candidates.ids)
        #projects = candidates.find(id:candidates.ids).projects
        
        # projects = Array.new

        # #array = Array.new[3]{Array.new[2]}
        # if (candidates.exists?)
        #   for i in 0...candidates.size 
        #     projects[i] = candidates[i].projects
        #     #array[i][1] = projects[i]
        #   end  
        # end

        # projects = user.candidates

        # candidatesProject = CandidatesProject.where(candidate_id:candidates.ids)
        # project =  Project.where(id:(candidatesProject.ids))
        

        
        
        # rescue StandardError
        #   render json: { status: 'Error', message: 'User not found' }, status: 404
      end
      # ...................................................................................

      def create
        user = User.new(user_params)
        if user.save
          candidate = Candidate.new(user_id: user.id, name: user.name, email: user.email)
          render json: { status: 'Success', message: 'Record saved', data: user }, status: :ok if candidate.save
        end
      rescue StandardError
        render json: { status: 'Error', message: 'User not saved' }, status: :unprocessable_entity
      end
      # .............................................................................

      def destroy
        user = User.find(params[:id])
        user.destroy!
        render json: { status: 'Success', message: 'Deleted user', data: user }, status: :ok
      rescue StandardError
        render json: { status: 'Error', message: 'User not destroyed' }, status: :unprocessable_entity
      end
      # .............................................................................

      def update
        user = User.find(params[:id])
        user.update!(user_params)
        render json: { status: 'Success', message: 'Updated user', data: user }, status: :ok
      rescue StandardError
        render json: { status: 'Error', message: 'User not updated' }, status: :unprocessable_entity
      end

#       def options
#         @options || = {}
#       end
      # ..............................................................................

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :role)
      end
    end
  end
end
