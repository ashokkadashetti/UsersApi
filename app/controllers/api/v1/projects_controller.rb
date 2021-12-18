# frozen_string_literal: true

module Api
  module V1
    # class
    class ProjectsController < ApplicationController
      def index
        project = Project.order('created_at ASC')
        projects = ProjectBlueprint.render_as_hash(project, view: :normal)
        render json: { status: 'Success', message: 'Loaded project', data: projects }, status: 200
      rescue StandardError
        render json: { status: 'Error', message: 'Project not loaded' }, status: :unprocessable_entity
      end

      # ..............................................................................................

      def show
        project = Project.find(params[:id])
        projects = ProjectBlueprint.render_as_hash(project, view: :association)
        render json: { status: 'Success', message: 'Project found', project: projects }, status: 302
      rescue StandardError
        render json: { status: 'Error', message: 'Project not found for this id' }, status: :unprocessable_entity
      end

      # ...............................................................................................
      def create
        project = Project.new(project_params)
        begin
          project.save!
          render json: { status: 'Success', message: 'Saved project', data: project }, status: 201
        rescue StandardError
          render json: { status: 'Error', message: 'Project not saved' }, status: :unprocessable_entity
        end
      end

      # ...........................................................................
      def destroy
        project = Project.find(params[:id])
        begin
          project.destroy!
          render json: { status: 'Success', message: 'Deleted project', data: project }, status: 204
        rescue StandardError
          render json: { status: 'Error', message: 'Project not destroyed' }, status: :unprocessable_entity
        end
      end

      # ................................................................................
      def update
        project = Project.find(params[:id])
        project.update!(project_params)
        render json: { status: 'Success', message: 'Updated project', data: project }, status: 201
      rescue StandardError
        render json: { status: 'Error', message: 'Project not updated' }, status: :unprocessable_entity
      end

      # ................................................................................
      private

      def project_params
        params.require(:project).permit(:name, :description, :idle, :realtime, :bill)
      end
    end
  end
end
