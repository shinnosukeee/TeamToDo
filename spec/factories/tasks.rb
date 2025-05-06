FactoryBot.define do
  factory :task do
    title { "サンプルタスク" }
    due_date { Date.today + 7.days }
    status { :not_started }
    association :team
  end
end
