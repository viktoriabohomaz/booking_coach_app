class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :time_slot
  has_one :coach, through: :time_slot

  enum status: {
    pending: 'pending',
    cancelled: 'cancelled'
  }
end
