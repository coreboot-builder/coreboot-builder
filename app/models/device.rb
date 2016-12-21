class Device < ActiveRecord::Base
  validates :name, presence: true
  validates :vendor, presence: true
  validates :codename, presence: true
  validates :commit, presence: true

  belongs_to :vendor

  has_many :builds
  has_many :options
end