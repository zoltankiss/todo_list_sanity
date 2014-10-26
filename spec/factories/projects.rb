FactoryGirl.define do
  factory :project do
    name { Faker::Lorem.name }
    user { FactoryGirl.create(:user) }
  end
end