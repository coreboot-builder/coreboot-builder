class Configuration < ActiveRecord::Base
  validates :build, presence: true
  validates :option, presence: true
  validates :value, presence: true

  belongs_to :build
  belongs_to :option
end
