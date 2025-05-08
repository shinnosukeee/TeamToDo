class Team < ApplicationRecord
  before_validation :generate_join_code, on: :create
  validates :name, presence: true

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :tasks, dependent: :destroy

  belongs_to :owner, class_name: "User"

  private

  def generate_join_code
    self.join_code ||= "TEAM-" + SecureRandom.alphanumeric(6).upcase
  end
end
