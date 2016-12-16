class Option < ActiveRecord::Base
  validates :label, presence: true

  has_and_belongs_to_many :devices
end
