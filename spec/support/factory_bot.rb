require "factory_bot_rails"

RSpec.configure do |config|
  Faker::Config.locale = "pt-BR"
  config.include FactoryBot::Syntax::Methods
end
