# typed: false
require_relative '../../lib/eulerrb/utils.rb'

RSpec.describe Utils do
  describe '.multiply' do
    let(:multiplicand) { 2 }
    let(:multiplier) { 3 }

    subject { described_class.multiply(multiplicand: multiplicand, multiplier: multiplier) }

    it 'multiplies the two numbers' do
      expect(subject).to eq 6
    end

    generative do
      context 'when the inputs are both positive' do
        let(:min) { 1 }
        let(:max_fixnum) { (2**62) - 1 }
        data(:multiplicand) { rand(min..max_fixnum) }
        data(:multiplier) { rand(min..max_fixnum) }

        it 'returns a positive value' do
          expect(subject).to be > 0
        end
      end

      context 'when the inputs are both negative' do
        let(:min_fixnum) { -2**62 }
        let(:max) { -1 }
        data(:multiplicand) { rand(min_fixnum..max) }
        data(:multiplier) { rand(min_fixnum..max) }

        it 'returns a positive value' do
          expect(subject).to be > 0
        end
      end

      context 'when one input is positive and the other is negative' do
        let(:one) { 1 }
        let(:negative_one) { -1 }
        let(:min_fixnum) { -2**62 }
        let(:max_fixnum) { (2**62) - 1 }
        data(:multiplicand) { rand(min_fixnum..negative_one) }
        data(:multiplier) { rand(one..max_fixnum) }

        it 'returns a negative value' do
          expect(subject).to be < 0
        end
      end
    end
  end
end
