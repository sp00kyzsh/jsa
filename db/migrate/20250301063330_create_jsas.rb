class CreateJsas < ActiveRecord::Migration[8.0]
  def change
    create_table :jsas do |t|
      t.string :job_description
      t.date :date
      t.string :location
      t.string :facilitator
      t.string :marathon_rep
      t.string :safety_rep
      t.string :work_crew_supervisor

      t.text :critical_steps
      t.text :potential_hazards
      t.text :safety_measures
      t.text :procedures_reviewed
      t.text :worst_case
      t.text :special_tools

      t.string :potential_hazard_key, array: true, default: []
      t.string :required_ppe, array: true, default: []
      t.string :required_protection_key, array: true, default: []
      t.string :body_part_key, array: true, default: []
      t.string :training_required, array: true, default: []
      t.string :mobile_equipment, array: true, default: []
      t.string :other_inspections, array: true, default: []

      t.string :employee_name
      t.string :initials
      t.date :submission_date
      t.time :submission_time

      t.string :foreman_signature
      t.string :operations_signature
      t.string :safety_rep_signature
      t.date :audit_date
      t.date :signature_date

      t.timestamps
    end
  end
end
