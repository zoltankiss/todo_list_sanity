class Ability
  include CanCan::Ability

  def initialize(user)
    can :view, Project do |project|
      project.users_shared_with.include?(user)
    end
  end
end
