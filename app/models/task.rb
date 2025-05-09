class Task < ApplicationRecord
  belongs_to :team
  belongs_to :user, optional: true
  enum status: {not_started: 0, in_progress: 1, verifying: 2, done: 3}
  validates :title, presence: true
  validates :due_date, presence: true

  def status_class
    case status
    when "not_started" then "bg-gray-200 text-gray-800"
    when "in_progress" then "bg-yellow-200 text-yellow-800"
    when "verifying" then "bg-green-200 text-green-800"
    when "done" then "bg-red-200 text-red-800"
    else "bg-white text-gray-800"
    end
  end
  def self.status_options
    {
      "着手前" => :not_started,
      "開発中" => :in_progress,
      "確認中" => :verifying,
      "完了"   => :done
    }
  end
  def status_label
    self.class.status_options.key(status.to_sym) || status
  end

end
