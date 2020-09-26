# typed: false
RSpec.describe Eulerrb do
  it 'has a version number' do
    expect(Eulerrb::VERSION).not_to be nil
  end

  describe '.solve' do
    let(:problem) { nil }
    subject { described_class.solve(problem: problem) }

    context 'when the solution has been implemented' do
      let(:problem) { 1 }

      it 'returns a value' do
        expect(subject).to be_truthy
      end
    end

    context 'when the solution has not yet been implemented' do
      let(:problem) { 789 }

      it 'raises an error' do
        expect { subject }.to raise_error(StandardError, 'not yet implemented')
      end
    end
  end
end
