class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.admin_role?
        admin_abilities
      else
        user_abilities
      end
    else
      can %i(create new confirm_email), [User]
    end
  end

  private

  def admin_abilities
    can %i(create read update destroy confirm_email), [User, Journal]
  end

  def user_abilities
    can %i(create read update destroy confirm_email), [User, Journal]
  end
end
