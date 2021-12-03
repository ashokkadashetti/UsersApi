class Project < ApplicationRecord

	validates :name, presence: true
	validates :description, presence: true
	validates :idle, presence: true
	validates :realtime, presence: true
	validates :bill, presence: true

end
