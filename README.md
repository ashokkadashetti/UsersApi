# README

> Created API for Users.

### Things coverd here:

- Created User model (attributes => name, email, password, role).
- Added enum data type to role attribute[manager, admin, role].
- Created Project model (attributes => name, description, idle, realtime, bill).
- Implemented one_to_has_many relationship between user and candidate model.
- Created Candidate model (attributes => name, email, user_id).
- Added one USER to two models using users_controller.
- Implemented custom exceptions to candidate controller.
- Added Rubocop for offens detection.
- Implemented has_and_belongs_to_many relationship between candidates and project model.
- Implemented exception handling for users_controller and candidates_controller.
- Sending two table data through single json object from user api.



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

