# frozen_string_literal: true

module Api
  module V1
    # class
    class UsersController < ApplicationController
      def index
        users = User.order('created_at ASC')
        render json: { status: 'Success', message: 'Loaded users', data: users }, status: :ok
      rescue StandardError
        render json: { status: 'Error', message: 'Unavailable' }, status: :unprocessable_entity
      end
      # ...................................................................................

      def show
        user = User.find(params[:id])
        render json: { status: 'Success', message: 'User shown', data: user }, status: :ok
      rescue StandardError
        render json: { status: 'Error', message: 'Unavailable' }, status: :unprocessable_entity
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
