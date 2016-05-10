class Job < ActiveRecord::Base
  has_one: :user
end
