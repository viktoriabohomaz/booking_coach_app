class TimeSlot < ApplicationRecord
  belongs_to :coach
  has_many :appointments

  scope :available, -> { where(available: true) }
end
