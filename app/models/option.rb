class Option < ActiveRecord::Base
  validates :label, presence: true
  validates :device, presence: true

  belongs_to :device
end
