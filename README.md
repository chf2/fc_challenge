### Running the code
Clone this repo, then run `bin/prime_table_printer`. Optionally specify 
the number of primes for which to run, e,g. 
`bin/prime_table_printer 100`. The default number of primes is 10. To 
run tests, run `bundle install` if needed for `rspec`, then run 
`bundle exec rspec spec/`

### Classes
The code is split into two classes and relevant tests:

**PrimeGenerator**

Takes a number N and returns an array of the first N primes. 

**MultiplicationTablePrinter**

Takes a list of N numbers and prints an (N + 1) x (N + 1) 
multiplication table of those numbers.
 
### Process

The PrimeGenerator class uses a sieve method to improve the efficiency
of finding the first N primes over a naive approach. I realized while 
implementing this that I wasn't sure how to allocate a size up-front and 
guarantee that the max size would be greater than the nth prime. I've 
taken an approach of allocating a fixed size and then doubling the 
size of the sieve when necessary. I don't think this is optimal but 
haven't been able to reason through a better approach yet.

Initially I created a PrimeMultiplier class that would generate a 2D 
array corresponding to the table of primes. I realized as I was writing
the printer that the PrimeMultiplier was using O(N^2) space and that 
we can calculate each row as we print it instead. This happens in the
MultiplicationTablePrinter class, which takes an arbitrary list of 
numbers and prints a multiplication table. Having this class do the 
table calculations themselves doesn't feel quite right, but a class
 created solely to generate cell values felt too small.

### Analysis

The solution presented uses O(NlgN) space because of the need to hold
the sieve in memory. This is because the nth prime number is estimated 
as NlgN according to the prime number theorem (I had to look this up). 

I am not certain about the time complexity of this solution. The naive
solution of iterating over divisors theoretically has N * sqrt(N) 
operations (so NlgN * sqrt(NlgN) if N is the number of primes), and 
this should upper bound the sieve method. Thinking about the sieve 
method, for each prime we will need to populate the sieve up to the 
estimated NlgN sieve size required to find N primes. Adding up all of 
the operations becomes:
```
NlgN/2 + NlgN/3 + NlgN/5 + NlgN/7 + ... 
```
Knowing that the partial sum of the reciprocal prime series is 
O(lglg(N)) (the partial sum I also needed to look up), this implies 
the time complexity of the sieve method is O(NlgNlglgN). This does not 
take into account the resizing of the sieve and reprocessing of the 
elements, but I believe that this only increases the amount of work 
being done by a constant factor due to the doubling method.
