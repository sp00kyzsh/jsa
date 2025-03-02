require "test_helper"

class JsasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @jsa = jsas(:one)
  end

  test "should get index" do
    get jsas_url
    assert_response :success
  end

  test "should get new" do
    get new_jsa_url
    assert_response :success
  end

  test "should create jsa" do
    assert_difference("Jsa.count") do
      post jsas_url, params: { jsa: { critical_steps: @jsa.critical_steps, date: @jsa.date, employee_name: @jsa.employee_name, facilitator: @jsa.facilitator, initials: @jsa.initials, job_description: @jsa.job_description, location: @jsa.location, marathon_rep: @jsa.marathon_rep, potential_hazards: @jsa.potential_hazards, procedures_reviewed: @jsa.procedures_reviewed, safety_measures: @jsa.safety_measures, safety_rep: @jsa.safety_rep, special_tools: @jsa.special_tools, submission_date: @jsa.submission_date, submission_time: @jsa.submission_time, work_crew_supervisor: @jsa.work_crew_supervisor, worst_case: @jsa.worst_case } }
    end

    assert_redirected_to jsa_url(Jsa.last)
  end

  test "should show jsa" do
    get jsa_url(@jsa)
    assert_response :success
  end

  test "should get edit" do
    get edit_jsa_url(@jsa)
    assert_response :success
  end

  test "should update jsa" do
    patch jsa_url(@jsa), params: { jsa: { critical_steps: @jsa.critical_steps, date: @jsa.date, employee_name: @jsa.employee_name, facilitator: @jsa.facilitator, initials: @jsa.initials, job_description: @jsa.job_description, location: @jsa.location, marathon_rep: @jsa.marathon_rep, potential_hazards: @jsa.potential_hazards, procedures_reviewed: @jsa.procedures_reviewed, safety_measures: @jsa.safety_measures, safety_rep: @jsa.safety_rep, special_tools: @jsa.special_tools, submission_date: @jsa.submission_date, submission_time: @jsa.submission_time, work_crew_supervisor: @jsa.work_crew_supervisor, worst_case: @jsa.worst_case } }
    assert_redirected_to jsa_url(@jsa)
  end

  test "should destroy jsa" do
    assert_difference("Jsa.count", -1) do
      delete jsa_url(@jsa)
    end

    assert_redirected_to jsas_url
  end
end
