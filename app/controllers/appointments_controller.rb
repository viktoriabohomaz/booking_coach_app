class AppointmentsController < ApplicationController
  before_action :load_coach, only: [:new]

  def new
    @available_time_slots = FetchTimeSlotsInfoService.new(@coach).call
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

  def load_coach
    @coach = Coach.includes(:time_slots).find(params[:coach_id])
  end
end
