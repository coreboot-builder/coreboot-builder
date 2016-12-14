class Choice < ActiveRecord::Base
  validates :option, presence: true
  validates :build, presence: true
  validates :value, presence: true

  belongs_to :option
  belongs_to :build
end