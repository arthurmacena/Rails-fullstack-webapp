FactoryBot.define do
  factory :user do
    name          { Faker::Name.name }
    email         { Faker::Internet.email }
    password      { Faker::Number.number  }
    role          { Faker::Number.between(from: 0, to: 1) }
    organization  { create(:organization) }
    slug          { organization.slug }

    factory :chief_editor_user do
      role          { 1 }
    end

    factory :writer_user do
      role          { 0 }
    end
  end
end
