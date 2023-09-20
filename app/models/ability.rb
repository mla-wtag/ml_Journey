class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    return unless user

    can :manage, User
  end

  private

  def user_abilities
    can %i(create read update destroy), User
  end

  def admin_abilities
    can %i(create read update destroy), User
  end
end
