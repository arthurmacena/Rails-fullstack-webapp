RSpec.configure do |config|
  config.before(:suite) do
    # Make the default tenant globally available to the tests
    @default_organization = FactoryBot.create(:organization)
  end

  config.before(:each) do
    ActsAsTenant.current_tenant = @default_organization
  end

  config.after(:each) do
    ActsAsTenant.current_tenant = nil
  end
end
