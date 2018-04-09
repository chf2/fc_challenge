# Takes a number of prime numbers to generate and exposes a #list_of_primes function to return them as a list
class PrimeGenerator
  attr_accessor :populated, :max_sieve_size
  attr_reader :sieve, :max_num_primes

  def initialize(max_num_primes)
    @max_num_primes = max_num_primes
    #         0,     1,
    @sieve = [false, false]
    @max_sieve_size = max_num_primes * 10
    @populated = false
  end

  def list_of_primes
    @primes ||= generate_primes
  end

  def generate_primes(start = 0)
    list_of_primes = []
    number = start
    while number < max_sieve_size && list_of_primes.length < max_num_primes
      if sieve[number].nil?
        sieve[number] = true
        list_of_primes << number
        multiple = number + number
        while multiple < max_sieve_size
          sieve[multiple] = false
          multiple = multiple + number
        end
      end
      number += 1
    end
    if list_of_primes.length < max_num_primes
      increase_sieve_size
      generate_primes
    end
    list_of_primes
  end

  # def increase_sieve_size
  #   puts 'here!!'
  #   self.max_sieve_size *= 2
  # end

  def is_prime?(number)
    raise 'Indeterminate -- number larger than sieve length' if number > sieve.length - 1
    sieve[number]
  end
end
