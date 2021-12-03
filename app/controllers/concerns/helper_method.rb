module HelperMethod

	extend ActiveSupport::Concern

	included do
		before_action :set_candidates
	end

	def set_candidates
		# if current_user
		# 	candidate = Candidate.new(user_id:current_user.id, name:current_user.name, email:current_user.email)
		# 		if candidate.save
		# 			#format.html{respond_to users_path}
		# 		end
		# end

		if user
			candidate = Candidate.new(user_id:user.id, name:user.name, email:user.email)
			if candidate.save
				render json: {status: 'Success', message: 'Saved project', data:project}, status: :ok
			else
				render json: {status: 'Error', message: 'Project not saved', data:project}, status: :ok
			end

		end
	end

end

 