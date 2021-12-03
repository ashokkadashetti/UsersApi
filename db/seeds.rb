3.times do |user|
	User.create!(
		name: "softsuave #{user}",
		email: "softsuave#{user}@gmail.com",
		password: "12345#{user}",
		role: "TL"
	)
end

puts "3 Users created!"

3.times do |proj|
	Project.create!(
		name: "Project #{proj}",
		description: "description#{proj}",
		idle: "idle#{proj}",
		realtime: "realtime#{proj}",
		bill: "bill#{proj}"
	)
end

puts "3 Users created!"
