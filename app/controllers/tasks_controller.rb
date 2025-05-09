class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team
  before_action :set_task, only: %i[edit show update destroy]
  def new
    @task = @team.tasks.build
  end

  def index
    @team = Team.find(params[:team_id])
    @tasks = @team.tasks.order(due_date: :asc)
  end
  def create
    @task = @team.tasks.build(task_params)
    if @task.save
      redirect_to @team, notice:"タスクを作成しました"
    else
      render :new
    end
  end

  def show

  end
  def edit
  end

  def update
    if  @task.update(task_params)
      redirect_to @team, notice: "タスクを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to @team,notice:"タスクを削除しました"
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_task
    @task = @team.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status)
  end
end
