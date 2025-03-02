class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.date :hiring_date
      t.string :job_title
      t.boolean :active
      t.string :employment_status
      t.text :notes

      t.timestamps
    end
  end
end
