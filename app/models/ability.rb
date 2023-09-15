# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can %i(create read update destroy), User
  end
end
