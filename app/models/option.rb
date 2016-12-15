class Option < ActiveRecord::Base
  validates :label, presence: true

  has_many :choices

  has_and_belongs_to_many :devices
end