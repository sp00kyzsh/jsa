class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]

  # GET /employees or /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1 or /employees/1.json
  def show
    @employee = Employee.find(params[:id])
    @time_logs = @employee.employee_time_logs.order(clock_in: :desc) # ⬅ Ensures most recent first
    @total_hours = calculate_total_hours(@employee)
    @ytd_hours = calculate_ytd_hours(@employee)

    # Filter for specific date range if requested
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date]).beginning_of_day
      end_date = Date.parse(params[:end_date]).end_of_day

      @filtered_hours = calculate_hours_in_range(@employee, start_date, end_date)
    end
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy!

    respond_to do |format|
      format.html { redirect_to employees_path, status: :see_other, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params.expect(:id))
  end

  def calculate_total_hours(employee)
    employee.employee_time_logs.where.not(clock_out: nil).sum do |log|
      ((log.clock_out - log.clock_in) / 3600.0).round(2)
    end
  end

  def calculate_ytd_hours(employee)
    start_of_year = Time.current.beginning_of_year
    employee.employee_time_logs.where("clock_in >= ?", start_of_year).where.not(clock_out: nil).sum do |log|
      ((log.clock_out - log.clock_in) / 3600.0).round(2)
    end
  end

  def calculate_hours_in_range(employee, start_date, end_date)
    employee.employee_time_logs.where(clock_in: start_date.to_date.beginning_of_day..end_date.to_date.end_of_day).where.not(clock_out: nil).sum do |log|
      ((log.clock_out - log.clock_in) / 3600.0).round(2)
    end
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.expect(employee: [ :first_name, :last_name, :hiring_date, :job_title, :active, :employment_status, :notes ])
  end
end
