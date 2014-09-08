FactoryGirl.define do
  factory :project do
    name { Faker::Lorem.name }
  end
end