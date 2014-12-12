require 'rails_helper'

describe Match, :type => :model do

  describe 'associations' do
    it { should have_many(:players)}
  end
end
