require_relative '../lib/prime_generator'

describe PrimeGenerator do
  describe '#list_of_primes' do
    # start by testing corner/base cases, then two more complex cases
    it 'returns correct results for 0-prime case' do
      generator = PrimeGenerator.new(0)
      expect(generator.list_of_primes).to eq([])
    end

    it 'returns correct results for 1-prime case' do
      generator = PrimeGenerator.new(1)
      expect(generator.list_of_primes).to eq([2])
    end

    it 'returns correct results for 2-prime case' do
      generator = PrimeGenerator.new(2)
      expect(generator.list_of_primes).to match_array([2, 3])
    end

    it 'returns correct results for longer prime case' do
      generator = PrimeGenerator.new(10)
      expect(generator.list_of_primes).to match_array([2, 3, 5, 7, 11, 13, 17, 19, 23, 29])
    end

    it 'returns correct results for 100 primes' do
      generator = PrimeGenerator.new(100)
      first_100_primes = File.readlines('spec/first_100_primes.txt').map(&:to_i)
      expect(generator.list_of_primes).to match_array(first_100_primes)
    end
  end
end
