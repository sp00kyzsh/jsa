class EmployeeTimeLogsController < ApplicationController
  before_action :set_employee, only: [:create, :update, :edit, :clock_out] # Add clock_out
  before_action :set_time_log, only: [:edit, :update, :clock_out] # Add clock_out

  def clock_in_page
    @employees = Employee.all
  end

  def create
    @employee = Employee.find(params[:employee_id])

    # Prevent duplicate clock-ins without clocking out
    if @employee.employee_time_logs.where(clock_out: nil).exists?
      redirect_to clock_in_path, alert: "You are already clocked in!"
      return
    end

    @time_log = @employee.employee_time_logs.create(clock_in: Time.current)
    if @time_log.persisted?
      redirect_to clock_in_path, notice: "Clocked in successfully!"
    else
      redirect_to clock_in_path, alert: "Error clocking in!"
    end
  end

  def clock_out
    @time_log = @employee.employee_time_logs.where(clock_out: nil).last

    if @time_log.nil?
      redirect_to clock_in_path, alert: "You must clock in before clocking out!"
      return
    end

    @time_log.update(clock_out: Time.current)
    redirect_to clock_in_path, notice: "Clocked out successfully!"
  end

  def edit
  end

  def update
    if @time_log.update(time_log_params)
      redirect_to employee_path(@employee), notice: "Time log updated successfully!"
    else
      render :edit, alert: "Error updating time log."
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

  def set_time_log
    @time_log = @employee.employee_time_logs.find(params[:id])
  end

  def time_log_params
    params.require(:employee_time_log).permit(:clock_in, :clock_out)
  end
end
