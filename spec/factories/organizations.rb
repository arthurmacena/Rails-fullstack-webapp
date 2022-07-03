FactoryBot.define do
  factory :organization do
    name            { Faker::Lorem.sentence }
  end
end