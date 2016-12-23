class Option < ActiveRecord::Base
  validates :label, presence: true
  validates :device, presence: true
  validates :state, presence: true

  has_many :option_values

  belongs_to :device

  enum state: {
    active: 0,
    inactive: 10
  }
end
