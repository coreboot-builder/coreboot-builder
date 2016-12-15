class Device < ActiveRecord::Base
  validates :name, presence: true
  validates :config_file, presence: true
  validates :vendor, presence: true

  belongs_to :vendor

  has_many :builds

  has_and_belongs_to_many :options
end