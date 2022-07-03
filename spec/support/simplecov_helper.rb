require "simplecov"

SimpleCov.start "rails" do
  use_merging true
  minimum_coverage_by_file 0

  add_group "Controllers", "app/controllers"
  add_group "Mailers",     "app/mailers"
  add_group "Models",      "app/models"
  add_group "Policies",    "app/policies"
  add_group "Support",     "app/support"
  add_group "Libraries",   "lib"

  add_filter "config"
  add_filter "spec"
  add_filter "mailers"
  add_filter "helpers"
  add_filter "channels"
  add_filter "jobs"
  add_filter "app/policies/application_policy.rb"
  add_filter "app/models/application_record.rb"
  add_filter "app/controllers/application_controller.rb"
  add_filter "app/controllers/home_controller.rb"
  add_filter "app/controllers/users/"
end
