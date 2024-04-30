class Coach < ApplicationRecord
  has_many :time_slots
  has_many :appointments, through: :time_slots
  has_many :users, through: :appointments
end
