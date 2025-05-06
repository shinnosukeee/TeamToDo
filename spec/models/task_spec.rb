require 'rails_helper'

RSpec.describe Task, type: :model do
  it "有効なファクトリを持つ" do
    expect(FactoryBot.build(:task)).to be_valid
  end

  it "タイトルが必須" do
    task = FactoryBot.build(:task, title: nil)
    expect(task).not_to be_valid
  end

  it "期限が必須" do
    task = FactoryBot.build(:task, due_date: nil)
    expect(task).not_to be_valid
  end

  it "ステータスはenumとして定義されている" do
    expect(Task.statuses.keys).to include("not_started", "in_progress", "verifying", "done")
  end
end
