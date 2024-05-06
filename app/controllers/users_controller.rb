class UsersController < ApplicationController
  before_action :load_appointment, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      create_appointment_for_user
      redirect_to root_path, notice: 'Appointment successfully created!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :details)
  end

  def load_appointment
    @appointment = Appointment.new(session[:appointment])
  end

  def create_appointment_for_user
    appointment = Appointment.new(session[:appointment])
    appointment.user = @user
    appointment.save!
    appointment.time_slot.update!(available: false)

    session[:appointment] = nil
  end
end
