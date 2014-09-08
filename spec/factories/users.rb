FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              { 'Wasd123asd1?' }
    password_confirmation { 'Wasd123asd1?' }
  end
end