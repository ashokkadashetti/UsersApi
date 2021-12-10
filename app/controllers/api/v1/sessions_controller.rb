# frozen_string_literal: true

module Api
  module V1
    # class
    class SessionsController < ApplicationController
      def create
        if (user = User.where(email: params[:email]).first)
          if user.valid_password?(params[:password])
            # render json: { status: 'Success', message: 'Authorized user' }, status: :ok
            # if (candidate = Candidate.where(user_id: user.id)) , data: candidate 
            render json: { status: 'Success', message: 'Authorized user'}, status: :ok
            # end
          else
            render json: { status: 'Error', message: 'Wrong password' }, status: :unprocessable_entity
          end
        else
          render json: { status: 'Error', message: 'Email not valid' }, status: :unprocessable_entity
        end
      end
      # ...........................................................................................
    end
  end
end
