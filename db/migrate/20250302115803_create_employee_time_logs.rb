class CreateEmployeeTimeLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :employee_time_logs do |t|
      t.references :employee, null: false, foreign_key: true
      t.datetime :clock_in
      t.datetime :clock_out

      t.timestamps
    end
  end
end
