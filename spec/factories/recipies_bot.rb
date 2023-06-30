FactoryBot.define do
  factory :recipe do
    name { Faker::Name.unique.name }
  end
end
