require 'rails_helper'

RSpec.describe Option, type: :model do
  it { should validate_presence_of(:label) }

  it { should belong_to :device }
end
