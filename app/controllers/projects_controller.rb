class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :share]
  before_action :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    redirect_to project_tasks_path(@project)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  def share
    match = params['project']['user_url_to_share_with'].match(/.*users\/(\d+)/)

    if match.nil?
      redirect_to projects_path, notice: "Sorry that was an invalid url. <a href='/help'>more help</a>"
      return
    else
      id = match[1]
    end

    user_to_share_with = User.find(id)
    @project.users_shared_with << user_to_share_with
    redirect_to projects_path, notice: "Successfully shared #{@project.name} with #{user_to_share_with.email}"
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_project_task_order
    params['task'].map(&:to_i).each_with_index do |id, index|
      Task.find(id).update_attributes!(order: index)
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id] || params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :user_id)
    end
end
