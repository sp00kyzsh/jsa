class JsasController < ApplicationController
  before_action :set_jsa, only: %i[ show edit update destroy ]

  # GET /jsas or /jsas.json
  def index
    @jsas = Jsa.all
  end

  # GET /jsas/1 or /jsas/1.json
  def show
    @jsa = Jsa.find(params[:id])
  end


  # GET /jsas/new
  def new
    @jsa = Jsa.new
  end

  # GET /jsas/1/edit
  def edit
  end

  # POST /jsas or /jsas.json
  def create
    @jsa = Jsa.new(jsa_params)

    respond_to do |format|
      if @jsa.save
        format.html { redirect_to @jsa, notice: "Jsa was successfully created." }
        format.json { render :show, status: :created, location: @jsa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @jsa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jsas/1 or /jsas/1.json
  def update
    respond_to do |format|
      if @jsa.update(jsa_params)
        format.html { redirect_to @jsa, notice: "Jsa was successfully updated." }
        format.json { render :show, status: :ok, location: @jsa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @jsa.errors, status: :unprocessable_entity }
      end
    end
  end

  def pdf
    @jsa = Jsa.find(params[:id])
    pdf = Prawn::Document.new

    # Title
    pdf.text "Job Safety Analysis (JSA)", size: 24, style: :bold, align: :center
    pdf.move_down 20

    # Job Information Section
    pdf.text "Job Information", size: 16, style: :bold
    pdf.stroke_horizontal_rule
    pdf.move_down 10

    pdf.text "Job Description: #{@jsa.job_description}"
    pdf.text "Date: #{@jsa.date}"
    pdf.text "Location: #{@jsa.location}"
    pdf.text "Facilitator: #{@jsa.facilitator}"
    pdf.move_down 10

    # Team Information
    pdf.text "Team Information", size: 16, style: :bold
    pdf.stroke_horizontal_rule
    pdf.move_down 10

    pdf.text "Marathon Representative: #{@jsa.marathon_rep}"
    pdf.text "Safety Dept. Rep: #{@jsa.safety_rep}"
    pdf.text "Work Crew Supervisor: #{@jsa.work_crew_supervisor}"
    pdf.move_down 10

    # Job Steps, Hazards, Safety Measures
    pdf.text "Job Steps & Safety", size: 16, style: :bold
    pdf.stroke_horizontal_rule
    pdf.move_down 10

    pdf.text "Critical Job Steps/Sequence: #{@jsa.critical_steps}"
    pdf.text "Potential Accidents or Hazards: #{@jsa.potential_hazards}"
    pdf.text "Safety Measures to Address Hazards: #{@jsa.safety_measures}"
    pdf.text "Procedures Reviewed: #{@jsa.procedures_reviewed}"
    pdf.text "Worst Case: #{@jsa.worst_case}"
    pdf.text "Special Tools/Equipment/PPE: #{@jsa.special_tools}"
    pdf.move_down 10

    # Potential Hazard Key
    pdf.text "Potential Hazard Key", size: 16, style: :bold
    pdf.stroke_horizontal_rule
    pdf.move_down 10
    pdf.text @jsa.potential_hazard_key.join(", ")
    pdf.move_down 10

    # Required PPE
    pdf.text "Required PPE", size: 16, style: :bold
    pdf.stroke_horizontal_rule
    pdf.move_down 10
    pdf.text @jsa.required_ppe.join(", ")
    pdf.move_down 10

    # Required Protection Key
    pdf.text "Required Protection Key", size: 16, style: :bold
    pdf.stroke_horizontal_rule
    pdf.move_down 10
    pdf.text @jsa.required_protection_key.join(", ")
    pdf.move_down 10

    # Additional Safety Information
    pdf.text "Additional Safety Information", size: 16, style: :bold
    pdf.stroke_horizontal_rule
    pdf.move_down 10

    pdf.text "Body Part Key: #{@jsa.body_part_key.join(', ')}"
    pdf.text "Training Required: #{@jsa.training_required.join(', ')}"
    pdf.text "Mobile Equipment: #{@jsa.mobile_equipment.join(', ')}"
    pdf.text "Other Inspections: #{@jsa.other_inspections.join(', ')}"
    pdf.move_down 10

    # Employee Information
    pdf.text "Employee & Signatures", size: 16, style: :bold
    pdf.stroke_horizontal_rule
    pdf.move_down 10

    pdf.text "Employee Name: #{@jsa.employee_name}"
    pdf.text "Initials: #{@jsa.initials}"
    pdf.text "Submission Date: #{@jsa.submission_date}"
    pdf.text "Submission Time: #{@jsa.submission_time.strftime('%I:%M %p') if @jsa.submission_time.present?}"
    pdf.move_down 10

    # Supervision Audit Review
    pdf.text "Supervision Audit Review", size: 16, style: :bold
    pdf.stroke_horizontal_rule
    pdf.move_down 10

    pdf.text "Foreman Signature: #{@jsa.foreman_signature}"
    pdf.text "Operations Signature: #{@jsa.operations_signature}"
    pdf.text "Safety Rep Signature: #{@jsa.safety_rep_signature}"
    pdf.text "Audit Date: #{@jsa.audit_date}"
    pdf.text "Signature Date: #{@jsa.signature_date}"
    pdf.move_down 10

    # Generate and Send the PDF
    send_data pdf.render, filename: "jsa_#{@jsa.id}.pdf", type: "application/pdf", disposition: "inline"
  end



  # DELETE /jsas/1 or /jsas/1.json
  def destroy
    @jsa.destroy!

    respond_to do |format|
      format.html { redirect_to jsas_path, status: :see_other, notice: "Jsa was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jsa
      @jsa = Jsa.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def jsa_params
      params.require(:jsa).permit(
        :job_description, :date, :location, :facilitator, :marathon_rep, :safety_rep, :work_crew_supervisor,
        :critical_steps, :potential_hazards, :safety_measures, :procedures_reviewed, :worst_case, :special_tools,
        :employee_name, :initials, :submission_date, :submission_time,
        :foreman_signature, :operations_signature, :safety_rep_signature, :audit_date, :signature_date,
        potential_hazard_key: [], required_ppe: [], required_protection_key: [], body_part_key: [], training_required: [],
        mobile_equipment: [], other_inspections: []
      )
    end
end
