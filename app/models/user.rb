class User < ApplicationRecord
  # enum role: { user: 0, admin: 1 }

  # after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.role ||= :user
  # end

end
