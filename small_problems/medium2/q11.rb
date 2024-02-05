# A prime number is a positive number that is evenly divisible only by itself and 1.
# Thus, 23 is prime since its only divisors are 1 and 23. However, 24 is not prime
# since it has divisors of 1, 2, 3, 4, 6, 8, 12, and 24. Note that the number 1 is not prime.

# Write a method that takes a positive integer as an argument and returns true
# if the number is prime, false if it is not prime.

# You may not use Ruby's Prime class to solve this problem.
# Your task is to programmatically determine whether a number is prime
# without relying on any methods that already do that for you.

def is_prime(num)
  return false if num == 1

  max_divisor = num / 2
  (2..max_divisor).none? { |divisor| (num % divisor).zero? }
end

# Examples:
puts(is_prime(1) == false)              # true
puts(is_prime(2) == true)               # true
puts(is_prime(3) == true)               # true
puts(is_prime(4) == false)              # true
puts(is_prime(5) == true)               # true
puts(is_prime(6) == false)              # true
puts(is_prime(7) == true)               # true
puts(is_prime(8) == false)              # true
puts(is_prime(9) == false)              # true
puts(is_prime(10) == false)             # true
puts(is_prime(23) == true)              # true
puts(is_prime(24) == false)             # true
puts(is_prime(997) == true)             # true
puts(is_prime(998) == false)            # true
puts(is_prime(3_297_061) == true)       # true
puts(is_prime(23_297_061) == false)     # true
# puts(is_prime(7_202_218_937))

# faster solution
def is_prime2(num)
  return false if num == 1

  max_divisor = Math.sqrt(num)
  (2..max_divisor).each { |divisor| return false if (num % divisor).zero? }
  true
end

puts(is_prime2(1) == false)              # true
puts(is_prime2(2) == true)               # true
puts(is_prime2(3) == true)               # true
puts(is_prime2(4) == false)              # true
puts(is_prime2(5) == true)               # true
puts(is_prime2(6) == false)              # true
puts(is_prime2(7) == true)               # true
puts(is_prime2(8) == false)              # true
puts(is_prime2(9) == false)              # true
puts(is_prime2(10) == false)             # true
puts(is_prime2(23) == true)              # true
puts(is_prime2(24) == false)             # true
puts(is_prime2(997) == true)             # true
puts(is_prime2(998) == false)            # true
puts(is_prime2(3_297_061) == true)       # true
puts(is_prime2(23_297_061) == false)     # true
puts(is_prime2(7_202_218_937))
