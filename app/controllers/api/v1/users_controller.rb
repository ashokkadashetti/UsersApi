# frozen_string_literal: true

module Api
  module V1
    # class
    class UsersController < ApplicationController
      def index
        users = User.order('created_at DESC')
        user = UserBlueprint.render_as_hash(users, view: :normal)
        render json: { status: 'Success', message: 'Loaded users', data: user }, status: 200
      rescue StandardError => e
        render json: { status: 'Error', message: e.message }, status: :unprocessable_entity
      end
      # ...................................................................................

      def show
        user = User.find_by(id: params[:id])
        candidates = user.candidates || []

        usr = user.to_json(except: %i[created_at updated_at])
        user1 = JSON.parse(usr)

        project = candidates.to_json(except: %i[created_at updated_at user_id], include: [projects: { only: %i[id name description bill] }])
        projects = JSON.parse(project)

        render json: { status: 'Success', message: 'User found', user: user1, candidates: projects }, status: 302
      rescue StandardError
        render json: { status: 'Error', message: 'User not found' }, status: 404
      end
      # ...................................................................................

      def create
        user = User.new(user_params)
        if user.save
          candidate = Candidate.new(user_id: user.id, name: user.name, email: user.email)
          render json: { status: 'Success', message: 'Record saved', data: user }, status: 201 if candidate.save
        end
      rescue StandardError
        render json: { status: 'Error', message: 'User not saved' }, status: :unprocessable_entity
      end
      # .............................................................................

      def destroy
        user = User.find(params[:id])
        user.destroy!
        render json: { status: 'Success', message: 'Deleted user', data: user }, status: 204
      rescue StandardError
        render json: { status: 'Error', message: 'User not destroyed' }, status: :unprocessable_entity
      end
      # .............................................................................

      def update
        user = User.find(params[:id])
        user.update!(user_params)
        render json: { status: 'Success', message: 'Updated user', data: user }, status: 200
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
