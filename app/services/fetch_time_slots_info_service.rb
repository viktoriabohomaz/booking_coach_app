# frozen_string_literal: true

class FetchTimeSlotsInfoService
  attr_reader :coach

  def initialize(coach)
    @coach = coach
  end

  def call
    fetch_available_time_slots(coach)
  end

  private

  def fetch_available_time_slots(coach)
    Rails.cache.fetch(cache_key(coach), expires_in: 1.hour) do
      available_time_slots = {}
      @coach.time_slots.each do |time_slot|
        date = time_slot.start_time.to_date.strftime('%a, %d %b %Y')
        available_time_slots[date] ||= []
        available_time_slots[date] << time_slot
      end
      available_time_slots
    end
  end

  def cache_key(coach)
    "coach_#{coach.id}_time_slots"
  end
end
