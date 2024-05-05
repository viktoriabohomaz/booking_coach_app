namespace :time_slots do
  # rake time_slots:create[2]
  desc "Create time slots"
  task :create, [:months_ahead] => :environment do |task, args|
    months_ahead = args[:months_ahead].to_i || 1
    puts "Creating time slots for the next #{months_ahead} month(s)"

    start_date = Date.current.beginning_of_month
    end_date = (Date.current + months_ahead.months).end_of_month

    (start_date..end_date).each do |date|
      Coach.all.each do |coach|
        next if coach.time_slots.where(start_time: date.all_day).exists?

        availabilities = coach.availabilities.where(day_of_week: date.strftime("%A"))

        availabilities.each do |availability|
          start_time_utc = Time.use_zone(availability.time_zone) do
            ActiveSupport::TimeZone[availability.time_zone].parse("#{date} #{availability.available_at}").utc
          end

          end_time_utc = Time.use_zone(availability.time_zone) do
            ActiveSupport::TimeZone[availability.time_zone].parse("#{date} #{availability.available_until}").utc
          end

          current_time_utc = start_time_utc

          while current_time_utc < end_time_utc
            new_end_time_utc = current_time_utc + 30.minutes
            coach.time_slots.create!(start_time: current_time_utc, end_time: new_end_time_utc)
            current_time_utc = new_end_time_utc
          end
        end
      end
    end

    puts "Time slots for the next #{months_ahead} month(s) have been generated!"
  end
end
