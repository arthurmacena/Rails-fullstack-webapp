FactoryBot.define do
  factory :comment do
    body          { Faker::Lorem.sentences }
    user          { create(:user) }
    organization  { create(:organization) }
    story         { create(:story) }
  end
end
