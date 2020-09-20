require_relative '../../lib/eulerrb/cache.rb'

RSpec.describe Cache do
  subject { described_class.instance }

  describe '#get' do
    let(:key) { 'key' }
    let(:value) { 'value' }

    context 'when the key is in the cache' do
      before { subject.set(key: key, value: value) }

      it 'returns a value' do
        expect(subject.get(key: key)).to eq value
      end
    end

    context 'when the key is not in the cache' do
      let(:missing_key) { 'missing_key' }

      it 'returns nil' do
        expect(subject.get(key: missing_key)).to be_nil
      end
    end
  end

  describe '#set' do
    let(:another_key) { 'another_key' }
    let(:another_value) { 'another_value' }

    it 'sets a value' do
      expect { subject.set(key: another_key, value: another_value) }
        .to change { subject.get(key: another_key) }.from(nil).to(another_value)
    end
  end

  describe '#reset' do
    let(:yet_another_key) { 'yet_another_key' }
    let(:yet_another_value) { 'yet_another_value' }

    before { subject.set(key: yet_another_key, value: yet_another_value) }

    it 'empties the cache' do
      expect { subject.reset }.to change { subject.count }.to(0)
    end
  end
end
