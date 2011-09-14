class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role? :admin
      can :manage, :all
    elsif user.role? :general_manager
      can :manage, :all
    elsif user.role? :store
      can :manage, :all
    end
  end
end
