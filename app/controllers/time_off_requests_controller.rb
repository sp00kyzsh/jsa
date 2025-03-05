class TimeOffRequestsController < ApplicationController
  before_action :set_employee, except: [ :index, :update ]  # ⬅ Skip `set_employee` for `index` & `update`
  before_action :set_time_off_request, only: [ :update, :destroy ]

  def index
    @pending_requests = TimeOffRequest.where(status: "pending").order(start_date: :asc)
    @approved_requests = TimeOffRequest.where(status: "approved").order(start_date: :asc)
    @denied_requests = TimeOffRequest.where(status: "denied").order(start_date: :asc) # ⬅ Add denied requests
  end

  def new
    @time_off_request = @employee.time_off_requests.new
  end

  def create
    @time_off_request = @employee.time_off_requests.new(time_off_request_params)

    if @time_off_request.save
      redirect_to employee_time_off_requests_path(@employee), notice: "Time off request submitted successfully."
    else
      render :new, alert: "Error submitting request."
    end
  end

  def update
    if @time_off_request.update(status: params[:status])
      redirect_to time_off_requests_path, notice: "Time-off request updated successfully."
    else
      redirect_to time_off_requests_path, alert: "Error updating request."
    end
  end

  def destroy
    @time_off_request.destroy
    redirect_to employee_time_off_requests_path(@employee), notice: "Time off request deleted."
  end

  private

  def set_employee
    @employee = Employee.find_by(id: params[:employee_id]) # Use `find_by` to prevent crashes
    if @employee.nil? && params[:employee_id].present?
      redirect_to employees_path, alert: "Employee not found."
    end
  end

  def set_time_off_request
    if params[:employee_id].present?
      @time_off_request = Employee.find(params[:employee_id]).time_off_requests.find(params[:id])
    else
      @time_off_request = TimeOffRequest.find(params[:id]) # ✅ Fetch without needing `@employee`
    end
  end

  def time_off_request_params
    params.require(:time_off_request).permit(:start_date, :end_date, :note)
  end
end
