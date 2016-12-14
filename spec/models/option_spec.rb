require 'rails_helper'

RSpec.describe Option, type: :model do
  it { should validate_presence_of(:label) }

  it { should have_and_belong_to_many :devices }
  it { should have_many :choices }
end
