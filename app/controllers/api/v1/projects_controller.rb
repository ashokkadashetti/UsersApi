# frozen_string_literal: true

module Api
  module V1
    # class
    class ProjectsController < ApplicationController
      #before_action :set_project, only: %i[show update destroy]
      def index
        projects = Project.order('created_at DESC')
        render json: { status: 'Success', message: 'Loaded project', data: projects }, status: :ok
      rescue StandardError
        render json: { status: 'Error', message: 'Project not loaded' }, status: :unprocessable_entity
      end

      # ..............................................................................................

      def show
        project = Project.find(params[:id])
        candidates = project.candidates || []
        render json: { status: 'Success', message: 'Project found', project: project, data: candidates }, status: :ok
      rescue StandardError
        render json: { status: 'Error', message: 'Project not found for this id' }, status: :unprocessable_entity
      end

      # ...............................................................................................
      def create
        project = Project.new(project_params)
        begin
          project.save!
          render json: { status: 'Success', message: 'Saved project', data: project }, status: :ok
        rescue StandardError
          render json: { status: 'Error', message: 'Project not saved' }, status: :unprocessable_entity
        end
      end

      # ...........................................................................
      def destroy
        project = Project.find(params[:id])
        begin
          project.destroy!
          render json: { status: 'Success', message: 'Deleted project', data: project }, status: :ok
        rescue StandardError
          render json: { status: 'Error', message: 'Project not destroyed' }, status: :unprocessable_entity
        end
      end

      # ................................................................................
      def update
        project = Project.find(params[:id])
        project.update!(project_params)
        render json: { status: 'Success', message: 'Updated project', data: project }, status: :ok
      rescue StandardError
        render json: { status: 'Error', message: 'Project not updated' }, status: :unprocessable_entity
      end

      # ................................................................................
      private

      def project_params
        params.permit(:name, :description, :idle, :realtime, :bill)
      end

      # def set_project
      #   project = Project.find(params[:id])
      # end
    end
  end
end
