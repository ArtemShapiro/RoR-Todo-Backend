FactoryGirl.define do
  factory :comment do
    text { Faker::App.name }
    task
  end
end
