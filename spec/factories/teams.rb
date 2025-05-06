FactoryBot.define do
  factory :team do
    name { "開発チームA" }
    association :owner, factory: :user
  end
end
