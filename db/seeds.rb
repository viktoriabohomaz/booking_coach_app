# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

require 'csv'

# CREATE AVAILABILITIES FOR COACHES

puts "Deleting existing availabilities..."
Availability.destroy_all

puts "Creating availabilities for coaches..."

CSV.foreach(Rails.root.join('coaches_schedule.csv'), headers: true) do |row|
  coach_name = row['Name']
  timezone = row['Timezone']
  day_of_week = row['Day of Week']
  available_at = row['Available at']
  available_until = row['Available until']

  coach = Coach.find_or_create_by!(name: coach_name)
  coach.availabilities.create!(
    day_of_week: day_of_week.strip,
    available_at: available_at.strip,
    available_until: available_until.strip,
    time_zone: timezone.sub(/\([^()]+\)/, '').strip
  )
end

puts "Availabilities created!"
