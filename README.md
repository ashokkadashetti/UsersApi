# README

> Created API for Users.

### Things coverd here:

- Created User model (attributes => name,email,password,role).
- Created Project model (attributes => name,description,idle,realtime,bill).
- Implemented one_to_has_many relationship between user and candidate model.
- Created Candidate model (attributes => name,email,user_id).
- Added one USER to two models using users_controller.
- Implemented exception handling for users_controller and candidates_controller.



### Code to add user to two models (model => user and candidate)

- If we add user to users model, then it will avilable in candidates model also.

```ruby

	def create
		user = User.new(user_params)

		if user.save
			candidate = Candidate.new(user_id:user.id, name:user.name, email:user.email)

			if candidate.save
				render json: {status: 'Success', message: 'Record saved', data:user}, status: :ok
			else
				render json: {status: 'Error', message: 'User not saved', data:user.error}, status: :unprocessable_entity
			end
		end

	end
```

