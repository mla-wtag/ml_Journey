class User < ApplicationRecord

	has_many :journals
	has_many :tasks


end
