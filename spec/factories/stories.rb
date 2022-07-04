FactoryBot.define do
  factory :story do
    title         { Faker::Lorem.sentence }
    content       { Faker::Lorem.paragraph_by_chars }
    organization  { create(:organization) }
  end
end
