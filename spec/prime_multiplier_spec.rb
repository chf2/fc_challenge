require_relative '../lib/prime_multiplier'

describe PrimeMultiplier do
  let(:list_of_primes) { [2, 3, 5, 7] }
  let(:multiplier) { PrimeMultiplier.new(list_of_primes) }

  describe '#prime_table' do
    let(:prime_table) { multiplier.prime_table }
    it 'returns a 2D array' do
      expect(prime_table).to be_kind_of(Array)
      expect(prime_table.first).to be_kind_of(Array)
    end

    # To create a header structure, shift the columns over by one and rows down by one
    it 'uses nil buffer for row/col starting point' do
      expect(prime_table.first.first).to be_nil
    end

    it 'has list of primes as tops of each column' do
      expect(prime_table.first).to match_array([nil] + list_of_primes)
    end

    it 'has list of primes as start of each row' do
      expect(prime_table.map(&:first)).to match_array([nil] + list_of_primes)
    end

    it 'is fully populated' do
      # A fully populated multiplication table should not have any nil or zero entries
      # aside from the one nil entry at the top-left corner
      nil_or_zero_entries = prime_table.flatten.select { |num|num.nil? || num.zero? }
      expect(nil_or_zero_entries.count).to eq(1)
    end

    it 'generates correct multiplications' do
      expect(prime_table.last.last).to eq(49)
    end

    it 'handles empty prime list gracefully' do
      empty_multiplier = PrimeMultiplier.new([])
      expect(empty_multiplier.prime_table).to eq([])
    end
  end
end
