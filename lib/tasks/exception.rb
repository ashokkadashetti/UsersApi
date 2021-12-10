# frozen_string_literal: true

# class
class ExceptionsHandler
  # class
  class AuthonticationError < StandardError
  end

  # class
  class UserError < StandardError
    def error_message
      'User name not matched'
    end
  end

  def self.handler_method(user)
    raise UserError if user.name.size > 3
    raise AuthonticationError if user.name.include?('.')
  end
end
