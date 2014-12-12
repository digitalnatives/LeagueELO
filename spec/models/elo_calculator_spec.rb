require 'rails_helper'

describe EloCalculator do
  let(:r1) { 2000 }
  let(:r2) { 2000 }
  let(:w1) { 2 }
  let(:w2) { 0 }
  subject { described_class.new(r1, r2, w1, w2) }

  describe '#delta' do
    it { expect(subject.delta).to eql 40.0 }

    context "2 wins with 1 loses" do
      let(:w2) { 1 }
      it { expect(subject.delta).to eql 20.0 }

      context "higher rated wins" do
        let(:r1) { 2100 }
        let(:r2) { 1900 }
        it { expect(subject.delta).to eql -11.169631197754946 }
      end
    end

    context "higher rated wins" do
      let(:r1) { 2100 }
      let(:r2) { 1900 }
      it { expect(subject.delta).to eql 19.220245868163374 }
    end

    context "lower rated wins" do
      let(:r1) { 1950 }
      let(:r2) { 2050 }
      it { expect(subject.delta).to eql 51.20519998423081 }
    end

    context "player 2 wins" do
      let(:r1) { 1900 }
      let(:r2) { 2100 }
      let(:w1) { 0 }
      let(:w2) { 2 }
      it { expect(subject.delta).to eql -19.220245868163367 }
    end
  end
end