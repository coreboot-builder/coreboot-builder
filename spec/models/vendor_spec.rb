require 'rails_helper'

RSpec.describe Vendor, type: :model do
  it { should validate_presence_of(:name) }

  it { should have_many :devices }
end
