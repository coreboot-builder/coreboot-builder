class Option < ActiveRecord::Base
  validates :label, presence: true
  validates :device, presence: true

  has_many :option_values

  belongs_to :device
end
