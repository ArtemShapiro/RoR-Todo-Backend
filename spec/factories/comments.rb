FactoryGirl.define do
  factory :comment do
    text { Faker::App.name }
    task
    attachment
  end
end
