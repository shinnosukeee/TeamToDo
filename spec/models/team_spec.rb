require 'rails_helper'

RSpec.describe Team, type: :model do
  it "有効なファクトリを持つ" do
    user = FactoryBot.create(:user)
    team = FactoryBot.create(:team, owner: user)
    expect(team).to be_valid
  end

  it "名前がないと無効" do
    user = create(:user)
    team = build(:team, name: nil, owner: user)
    expect(team).not_to be_valid
    expect(team.errors[:name]).to include("can't be blank")
  end


  it "join_codeを自動生成する" do
    user = create(:user)
    team = create(:team, owner: user)
    expect(team.join_code).to be_present
  end

  it "ownerがいないと無効" do
    team = build(:team, owner: nil)
    expect(team).not_to be_valid
    expect(team.errors[:owner]).to include("must exist")
  end

end
