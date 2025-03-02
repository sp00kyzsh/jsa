require "application_system_test_case"

class JsasTest < ApplicationSystemTestCase
  setup do
    @jsa = jsas(:one)
  end

  test "visiting the index" do
    visit jsas_url
    assert_selector "h1", text: "Jsas"
  end

  test "should create jsa" do
    visit jsas_url
    click_on "New jsa"

    fill_in "Critical steps", with: @jsa.critical_steps
    fill_in "Date", with: @jsa.date
    fill_in "Employee name", with: @jsa.employee_name
    fill_in "Facilitator", with: @jsa.facilitator
    fill_in "Initials", with: @jsa.initials
    fill_in "Job description", with: @jsa.job_description
    fill_in "Location", with: @jsa.location
    fill_in "Marathon rep", with: @jsa.marathon_rep
    fill_in "Potential hazards", with: @jsa.potential_hazards
    fill_in "Procedures reviewed", with: @jsa.procedures_reviewed
    fill_in "Safety measures", with: @jsa.safety_measures
    fill_in "Safety rep", with: @jsa.safety_rep
    fill_in "Special tools", with: @jsa.special_tools
    fill_in "Submission date", with: @jsa.submission_date
    fill_in "Submission time", with: @jsa.submission_time
    fill_in "Work crew supervisor", with: @jsa.work_crew_supervisor
    fill_in "Worst case", with: @jsa.worst_case
    click_on "Create Jsa"

    assert_text "Jsa was successfully created"
    click_on "Back"
  end

  test "should update Jsa" do
    visit jsa_url(@jsa)
    click_on "Edit this jsa", match: :first

    fill_in "Critical steps", with: @jsa.critical_steps
    fill_in "Date", with: @jsa.date
    fill_in "Employee name", with: @jsa.employee_name
    fill_in "Facilitator", with: @jsa.facilitator
    fill_in "Initials", with: @jsa.initials
    fill_in "Job description", with: @jsa.job_description
    fill_in "Location", with: @jsa.location
    fill_in "Marathon rep", with: @jsa.marathon_rep
    fill_in "Potential hazards", with: @jsa.potential_hazards
    fill_in "Procedures reviewed", with: @jsa.procedures_reviewed
    fill_in "Safety measures", with: @jsa.safety_measures
    fill_in "Safety rep", with: @jsa.safety_rep
    fill_in "Special tools", with: @jsa.special_tools
    fill_in "Submission date", with: @jsa.submission_date
    fill_in "Submission time", with: @jsa.submission_time.to_s
    fill_in "Work crew supervisor", with: @jsa.work_crew_supervisor
    fill_in "Worst case", with: @jsa.worst_case
    click_on "Update Jsa"

    assert_text "Jsa was successfully updated"
    click_on "Back"
  end

  test "should destroy Jsa" do
    visit jsa_url(@jsa)
    click_on "Destroy this jsa", match: :first

    assert_text "Jsa was successfully destroyed"
  end
end
