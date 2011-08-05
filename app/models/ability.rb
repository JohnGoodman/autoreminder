class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role? :admin
      can :manage, :all
    elsif user.role? :company
      can :manage, :all
    elsif user.role? :store
      can :manage, :all
    elsif user.role? :office
      can :manage, :all
    end
  end
end
