# frozen_string_literal: true

# class
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  enum role: { manager: 'manager', admin: 'admin', TL: 'TL' }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :candidates, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :role, presence: true

  accepts_nested_attributes_for :candidates,
                                allow_destroy: true,
                                update_only: true
end
