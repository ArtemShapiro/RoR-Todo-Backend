FactoryGirl.define do
  factory :project do
    name { Faker::App.name }
    user
  end
end
