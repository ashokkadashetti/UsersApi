# frozen_string_literal: true

# class
class ApplicationController < ActionController::API
  include CustomExcep

  # def success!(payload = {}, code = nil)
  #   code ||= :ok
  #   render json: { success: 'Success', payload: payload }, status: code
  # end

  # def fail!(errors, code = nil)
  #   msg = errors if errors.is_a? String
  #   code ||= :unprocessable_entity
  #   render json: { success: 'Error', errors: msg }, status: code
  # end
  
end
