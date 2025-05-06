class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: %i[show join leave edit update destroy invite remove_member]
  before_action :authorize_team_member!, only: %i[show]
  before_action :authorize_owner!, only: %i[edit update destroy invite remove_member]



  def index
    @teams = current_user.teams
  end

  def show
    @tasks = @team.tasks.order(due_date: :asc)
  end

  def new
    @team = Team.new
  end



  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: "チーム情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_path, notice:"チームを削除しました"
  end

  def join #初期になんとなく書いて必要ないが消すのが怖いので残している。
    unless current_user.teams.include?(@team)
      current_user.teams << @team
      notice = "チームに参加しました"
    else
      notice = "既に参加済みです"
    end
    redirect_to @team, notice: notice
  end

  def join_form

  end
  def join_by_code
    @team = Team.find_by(join_code: params[:join_code].strip.upcase)
    if @team.nil?
      redirect_to join_form_teams_path, alert: "無効なチームコードです"
    elsif current_user.teams.include?(@team)
      redirect_to @team, notice: "すでに参加済みです"
    else
      current_user.teams << @team
      redirect_to @team, notice: "チームに参加しました"
    end
  end

  def leave
    membership = Membership.find_by(user: current_user, team:@team)
    if membership
      membership.destroy
      redirect_to teams_path, notice: "チームから退出しました"
    else
      redirect_to teams_path, alert: "参加していません"
    end
  end

  def create
    @team = Team.new(team_params)
    @team.owner = current_user
    if @team.save
      @team.users << current_user
      redirect_to @team, notice: "チームを作成しました"
    else
      render :new
    end
  end

  def remove_member
    #未実装
  end

  def invite

  end

  private
  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :description)
  end

  def authorize_owner!
    redirect_to teams_path, alert: "権限がありません" unless @team.owner == current_user
  end
  def authorize_team_member!
    unless current_user.teams.include?(@team)
      redirect_to teams_path, alert: "このチームに参加していないため閲覧できません"
    end
  end

end