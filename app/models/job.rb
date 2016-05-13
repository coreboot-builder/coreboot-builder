class Job < ActiveRecord::Base
  belongs_to :user
  validates_format_of :uuid, :with => /\A[A-Za-z\d]([-\w]{,498}[A-Za-z\d])?\Z/i
end
