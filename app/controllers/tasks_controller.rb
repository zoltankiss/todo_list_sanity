class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :mark_as_complete, :mark_as_incomplete]
  before_action :set_project
  before_action :authenticate_user!

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = @project.tasks.where(finished: false).order(:order)
    @completed_tasks = @project.tasks.where(finished: true)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @project.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: project_task_path(@project, @task) }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: project_task_path(@project, @task) }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mark_as_complete
    @task.update_attributes!(finished: true)
    redirect_to project_tasks_path(@project)
  end

  def mark_as_incomplete
    @task.update_attributes!(finished: false)
    redirect_to project_tasks_path(@project)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:project_id_id, :title, :description)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
end
