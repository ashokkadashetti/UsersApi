# frozen_string_literal: true

# class
module CustomExcep
  extend ActiveSupport::Concern
  # class
  class UserNotFoundError < StandardError
    attr_reader :action

    def initialize(message, action)
      super(message)
      @action = action
    end
  end
end
