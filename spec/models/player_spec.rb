require 'rails_helper'

describe Player do

  describe 'associations' do
    it { should have_many(:matches) }
  end
end
