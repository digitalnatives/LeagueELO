require 'rails_helper'

describe Match, :type => :model do

  describe 'associations' do
    it { should have_many(:players)}
  end

  describe "#close!" do
    let(:a_1) { Player.create name: 'Player 1' }
    let(:a_2) { Player.create name: 'Player 2' }
    let(:b_1) { Player.create name: 'Player 3' }
    let(:b_2) { Player.create name: 'Player 4' }

    subject do
      described_class.new(
        team_a_players: [a_1, a_2],
        team_b_players: [b_1, b_2],
        score_a: 2,
        score_b: 0
      )
    end

    it "modify points" do
      subject.close!
      expect(a_1.reload.point).to eql 2040.0
      expect(a_2.reload.point).to eql 2040.0
      expect(b_1.reload.point).to eql 1960.0
      expect(b_2.reload.point).to eql 1960.0
    end

  end
end
