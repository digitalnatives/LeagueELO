require 'rails_helper'

describe MatchPlayer, :type => :model do

  describe 'associations' do
    it {should belong_to(:player)}
    it {should belong_to(:match)}
  end
end
