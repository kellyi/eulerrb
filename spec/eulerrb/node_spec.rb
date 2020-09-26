# typed: false
require_relative '../../lib/eulerrb/node.rb'

RSpec.describe Node do
  let(:matrix) do
    [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ]
  end
  let(:x) { 0 }
  let(:y) { 0 }
  subject { described_class.new(matrix: matrix, y: y, x: x) }

  describe '#up' do
    context 'when the coordinates are not at the top of the graph' do
      let(:x) { 0 }
      let(:y) { 1 }

      it 'returns a node' do
        expect(subject.up).to be_a Node
        expect(subject.up.weight).to eq 1
      end
    end

    context 'when the coordinates are at the top of the graph' do
      let(:x) { 0 }
      let(:y) { 0 }

      it 'returns nil' do
        expect(subject.up).to be_nil
      end
    end
  end

  describe '#down' do
    context 'when the coordinates are not at the bottom of the graph' do
      let(:x) { 0 }
      let(:y) { 0 }

      it 'returns a node' do
        expect(subject.down).to be_a Node
        expect(subject.down.weight).to eq 4
      end
    end

    context 'when the coordinates are at the bottom of the graph' do
      let(:x) { 0 }
      let(:y) { 2 }

      it 'returns nil' do
        expect(subject.down).to be_nil
      end
    end
  end

  describe '#left' do
    context 'when the coordinates are not on the left of the graph' do
      let(:x) { 2 }
      let(:y) { 0 }

      it 'returns a node' do
        expect(subject.left).to be_a Node
        expect(subject.left.weight).to be 2
      end
    end

    context 'when the coordinates are on the left of the graph' do
      let(:x) { 0 }
      let(:y) { 0 }

      it 'returns nil' do
        expect(subject.left).to be_nil
      end
    end
  end

  describe '#right' do
    context 'when the coordinates are not on the right of the graph' do
      let(:x) { 0 }
      let(:y) { 0 }

      it 'returns a node' do
        expect(subject.right).to be_a Node
        expect(subject.right.weight).to be 2
      end
    end

    context 'when the coordinates are on the right of the graph' do
      let(:x) { 2 }
      let(:y) { 0 }

      it 'returns nil' do
        expect(subject.right).to be_nil
      end
    end
  end

  describe '#weight' do
    it 'returns the weight at the given coordinates' do
      expect(subject.weight).to eq 1
    end
  end

  describe '#cost_distance_81' do
    let(:matrix) do
      [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
      ]
    end

    context 'when the node is in the bottom right corner' do
      let(:x) { matrix.first.length.pred }
      let(:y) { matrix.length.pred }

      it 'returns the node weight' do
        expect(subject.cost_distance_81).to eq 9
      end
    end

    context 'when the node is on the bottom' do
      let(:x) { 0 }
      let(:y) { 2 }

      it 'returns the sum of the nodes along the bottom' do
        expect(subject.cost_distance_81).to eq 24
      end
    end

    context 'when the node is on the right' do
      let(:x) { 2 }
      let(:y) { 0 }

      it 'returns the sum of the nodes along the right' do
        expect(subject.cost_distance_81).to eq 18
      end
    end

    context 'when the node is in the middle' do
      let(:x) { 1 }
      let(:y) { 1 }

      it 'returns the shortest path sum' do
        expect(subject.cost_distance_81).to eq 20
      end
    end

    context 'when the node is in the top right corner' do
      let(:x) { 0 }
      let(:y) { 0 }

      it 'returns the shortest cost distance' do
        expect(subject.cost_distance_81).to eq 21
      end
    end
  end
end
