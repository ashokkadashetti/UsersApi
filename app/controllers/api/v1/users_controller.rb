# frozen_string_literal: true

module Api
  module V1
    # class
    class UsersController < ApplicationController
      def index
        users = User.order('created_at ASC')
        render json: { status: 'Success', message: 'Loaded users', data: users }, status: :ok
      rescue StandardError => e
        render json: { status: 'Error', message: e.message }, status: :unprocessable_entity
      end
      # ...................................................................................

      def show
        user = User.find(params[:id])
        candidates = user.candidates || []

        usr = user.to_json(except: %i[created_at updated_at])
        user1 = JSON.parse(usr)

        # candi = CandidatesProject.where(candidate_id:candidates.ids)
        # candid = candi.to_json(include: [:candidate, :project])
        # can = JSON.parse(candid)

        project = candidates.to_json(except: %i[created_at updated_at user_id], include: [projects: { only: %i[id name description bill]}])
        projects = JSON.parse(project)

        render json: { status: 'Success', message: 'User found', user: user1, candidates: projects }, status: :ok
      rescue StandardError
        render json: { status: 'Error', message: 'User not found' }, status: 404
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
      # ..............................................................................

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :role)
      end
    end
  end
end
