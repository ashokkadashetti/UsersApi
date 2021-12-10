# frozen_string_literal: true

module Api
  module V1
    # class
    class CandidatesController < ApplicationController
      def index
        candidates = Candidate.order('created_at DESC')
        render json: { status: 'Success', message: 'Loaded candidates list', data: candidates }, status: :ok
      rescue StandardError
        render json: { status: 'Error', message: 'Unable to fetch' }, status: :unprocessable_entity
      end

      # ..........................................................................

      def show
        candidate = Candidate.find_by(id: params[:id])
        if candidate.present?
          candidate = Candidate.find(params[:id])
          projects = candidate.projects || []
          render json: { status: 'Success', message: 'User found', candidate: candidate, data: projects }, status: :ok
        else
          raise UserNotFoundError.new('candidate not found error custom exception', 'show')
        end
      rescue StandardError => e
        render json: { status: 'Error', message: e.message, action: e.action }, status: 404
      end

      # ...........................................................................

      def create
        candidate = Candidate.new(candidate_params)
        begin
          candidate.save!
          render json: { status: 'Success', message: 'Saved candidate', data: candidate }, status: :ok
        rescue StandardError
          render json: { status: 'Error', message: 'Candidate not saved' }, status: :unprocessable_entity
        end
      end

      # ................................................................................

      def destroy
        candidate = Candidate.find(params[:id])
        candidate.destroy!
        render json: { status: 'Success', message: 'Deleted candidate', data: candidate }, status: :ok
      rescue StandardError
        render json: { status: 'Error', message: 'Project not destroyed' }, status: :unprocessable_entity
      end

      # ................................................................................

      def update
        candidate = Candidate.find(params[:id])
        begin
          if candidate.update(candidate_params)
            render json: { status: 'Success', message: 'Updated candidate', data: candidate }, status: :ok
          end
        rescue StandardError
          render json: { status: 'Error', message: 'Candidate not updated' }, status: :unprocessable_entity
        end
      end

      # ...............................................................................

      private

      def candidate_params
        params.require(:candidate).permit(:name, :email, :user_id)
      end
    end
  end
end
