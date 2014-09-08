class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def projects
    #todo there's gotta be a better way to do this!
    shared_projects = Project.joins(:project_shares).where('project_shares.user_id' => self.id)
    owned_projects = Project.where(user_id: self.id)
    Project.where(id: shared_projects.map(&:id) + owned_projects.map(&:id))
  end
end
