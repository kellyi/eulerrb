# frozen_string_literal: true

require_relative '../../lib/eulerrb/problem1'

RSpec.describe Problem1 do
  describe '#multiple_of_three_or_five?' do
    let(:number) { 1 }
    subject { described_class.new }

    context 'when it is a multiple of five' do
      let(:number) { 50 }

      it 'returns true' do
        expect(subject.multiple_of_three_or_five?(n: number)).to be true
      end
    end

    context 'when it is a multiple of three' do
      let(:number) { 30 }

      it 'returns true' do
        expect(subject.multiple_of_three_or_five?(n: number)).to be true
      end
    end

    context 'when it is a multiple of neither 3 or 5' do
      let(:number) { 47 }

      it 'returns false' do
        expect(subject.multiple_of_three_or_five?(n: number)).to be false
      end
    end
  end
end
