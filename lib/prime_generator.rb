# Takes a number N of prime numbers to generate and exposes a #list_of_primes method to return them as a list.
# Uses a basic prime sieve to indicate, for each found prime, that the multiples of that number are not prime
# (up to some limit) and do not need to be checked for primeness.
#
# If the specified limit is reached before N primes have been calculated, double the limit and re-process the
# sieve to extend the multiples of each processed number and allow for processing of next series of numbers.
# The sieve is initialized as target_num_primes + 2 to satisfy the condition that target_num_primes == 1 requires 3
# elements, however a fixed base or multiple could improve the runtime of `#generate_primes` at the cost of
# extra space used in the worst case.
class PrimeGenerator
  attr_accessor :max_sieve_size
  attr_reader :sieve, :target_num_primes

  def initialize(target_num_primes)
    @target_num_primes = target_num_primes
    # The sieve represents numbers by their index in the specified array. The values are whether the
    # number is prime. We start by declaring 0 and 1 not prime.
    #         0,     1,
    @sieve = [false, false]
    @max_sieve_size = target_num_primes + 2
  end

  def list_of_primes
    @list_of_primes ||= generate_primes
  end

  private

  def generate_primes
    primes = []
    number_to_check = 0
    while primes.length < target_num_primes
      # For each number starting at the beginning of the sieve (0), check if we've processed it before.
      # If we haven't, it means it is not the multiple of a previously seen number and therefore must be
      # prime -- set the checked index to `true` and add it to our list.
      if sieve[number_to_check].nil?
        sieve[number_to_check] = true
        primes << number_to_check
        break if primes.length == target_num_primes
      end
      # Next, if the number is prime, mark all multiples of it as not prime up to the maximum sieve size.
      if sieve[number_to_check]
        populate_sieve(number_to_check)
      end
      # If we have reached the limit of the sieve size, double it. We need to re-process all of the elements
      # already seen again, though, in order to correctly find primes in the new range size - size * 2. Else,
      # continue to the next number.
      if number_to_check == max_sieve_size - 1
        self.max_sieve_size *= 2
        number_to_check = 0
      else
        number_to_check += 1
      end
    end
    primes
  end

  def populate_sieve(number)
    multiple = number * 2
    while multiple < max_sieve_size
      sieve[multiple] = false
      multiple += number
    end
  end
end
