class EmployeeTimeLogsController < ApplicationController
  before_action :set_employee, except: [ :clock_in_page ] # ✅ Now runs for destroy
  before_action :set_time_log, only: [ :edit, :update, :clock_out, :destroy ] # Add clock_out

  def clock_in_page
    @employees = Employee.all # ⬅ Make sure all employees load
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
    @employee = Employee.find(params[:employee_id])
    @time_log = @employee.employee_time_logs.find(params[:id])

    Rails.logger.info "Updating time log: #{@time_log.id}"
    Rails.logger.info "Clock-in: #{params[:employee_time_log][:clock_in]}"
    Rails.logger.info "Clock-out: #{params[:employee_time_log][:clock_out]}"

    begin
      @time_log.update!(time_log_params)
      redirect_to employee_path(@employee), notice: "Time log updated successfully!"
    rescue => e
      Rails.logger.error "Failed to update time log: #{e.message}"
      redirect_to employee_path(@employee), alert: "Error updating time log: #{e.message}"
    end
  end

  def destroy
    if @time_log.present?
      @time_log.destroy
      redirect_to employee_path(@employee), notice: "Time log deleted successfully."
    else
      redirect_to employee_path(@employee), alert: "Time log not found."
    end
  end

  private

  def set_employee
    @employee = Employee.find_by(id: params[:employee_id])
    if @employee.nil? && params[:employee_id].present?
      redirect_to employees_path, alert: "Employee not found."
    end
  end



  def set_time_log
    @time_log = EmployeeTimeLog.find_by(id: params[:id])

    if @time_log
      @employee = @time_log.employee # ✅ Dynamically set @employee
    else
      redirect_to employees_path, alert: "Time log not found."
    end
  end




  def calculate_total_hours(employee)
    total_minutes = employee.employee_time_logs.where.not(clock_out: nil).sum do |log|
      ((log.clock_out - log.clock_in) / 60.0) # Convert seconds to minutes
    end
    (total_minutes / 60.0).round(2) # Convert minutes to hours and round to 2 decimal places
  end

  def calculate_hours_in_range(employee, start_date, end_date)
    total_minutes = employee.employee_time_logs.where("clock_in >= ? AND clock_out <= ?", start_date, end_date)
    .where.not(clock_out: nil)
    .sum { |log| ((log.clock_out - log.clock_in) / 60.0) }
    (total_minutes / 60.0).round(2)
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
