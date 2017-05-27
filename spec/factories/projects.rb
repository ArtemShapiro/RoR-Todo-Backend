FactoryGirl.define do
  factory :project do
    name { Faker::App.name }
    user

    factory :project_with_tasks do
      transient { tasks_count Random.new.rand(2..9) }

      after(:create) do |project, evaluator|
        count = evaluator.tasks_count
        create_list :task, count, project: project
      end
    end
  end
end
