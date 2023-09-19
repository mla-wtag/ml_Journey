# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      admin_abilities
    else
      user_abilities
    end
  end

  private

  def user_abilities
    can %i(create read update destroy), User
  end

  def admin_abilities
    can %i(create read update destroy), User
  end
end
