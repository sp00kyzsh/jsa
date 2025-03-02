json.extract! employee, :id, :first_name, :last_name, :hiring_date, :job_title, :active, :employment_status, :notes, :created_at, :updated_at
json.url employee_url(employee, format: :json)
