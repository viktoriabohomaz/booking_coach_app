class AppointmentsController < ApplicationController
  before_action :load_coach_and_time_slots, only: [:new]

  def new
    @available_dates = @available_time_slots.keys
  end

  def create
    @appointment = Appointment.new(appointment_params)
    session[:appointment] = @appointment.attributes

    redirect_to new_user_path
  end

  private

  def appointment_params
    params.permit(:time_slot_id)
  end

  def load_coach_and_time_slots
    @coach = Coach.includes(:time_slots).find(params[:coach_id])
    @available_time_slots = Rails.cache.fetch("coach_#{params[:coach_id]}_time_slots", expires_in: 1.hour) do
      available_time_slots = {}
      @coach.time_slots.each do |time_slot|
        date = time_slot.start_time.to_date.strftime("%a, %d %b %Y")
        available_time_slots[date] ||= []
        available_time_slots[date] << time_slot if time_slot.available?
      end
      available_time_slots
    end
  end
end
