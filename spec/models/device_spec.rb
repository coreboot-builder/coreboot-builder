require 'rails_helper'

RSpec.describe Device, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:vendor) }

  it { should belong_to :vendor }

  it { should have_many :builds }

  it { should have_many :options}
end
