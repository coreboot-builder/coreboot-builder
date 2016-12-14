require 'rails_helper'

RSpec.describe Choice, type: :model do
  it { should validate_presence_of(:option) }
  it { should validate_presence_of(:build) }
  it { should validate_presence_of(:value) }

  it { should belong_to :option }
  it { should belong_to :build }
end
