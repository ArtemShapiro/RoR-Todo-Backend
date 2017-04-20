FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :user_with_projects do
      transient { projects_count Random.new.rand(1..9) }

      after(:create) do |user, evaluator|
        count = evaluator.projects_count
        create_list :project, count, user: user
      end
    end
  end
end
