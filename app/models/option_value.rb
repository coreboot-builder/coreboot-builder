class OptionValue < ActiveRecord::Base
  belongs_to :option
  validates :option, presence: true
  validates :value, presence: true
end
