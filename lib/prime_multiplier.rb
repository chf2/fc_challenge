# Takes a list of primes and returns a 2D array in the following structure
# [[nil,  2,  3,  5, ...],
#  [  2,  4,  6, 10, ...],
#  [  3,  6,  9, 15, ...],
#  [  5, 10, 15, 25, ...]]
#
class PrimeMultiplier
  attr_reader :prime_list

  def initialize(prime_list)
    @prime_list = prime_list
  end

  def prime_table
    return [] if prime_list.empty?
    @table ||= generate_prime_table
  end

  private

  def generate_prime_table
    table = Array.new(prime_list.length + 1) { Array.new(prime_list.length + 1) }
    table[0][0] = nil
    prime_list.each_with_index do |prime, idx|
      table[0][idx + 1] = prime # populate columns
      table[idx + 1][0] = prime # populate rows
    end
    col = 0
    while col < prime_list.length
      row = 0
      while row < prime_list.length
        table[row + 1][col + 1] = prime_list[row] * prime_list[col]
        row += 1
      end
      col += 1
    end

    table
  end
end
