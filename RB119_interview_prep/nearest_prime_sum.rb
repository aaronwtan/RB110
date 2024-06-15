=begin
P
input: array of integers
output: min integer value that can be appended to input array so that the sum of all elements
  including the appended num is equal to the nearest prime num that is greater than the current sum
  of the nums
  - input array will always contain at least 2 integers
  - all values in the array >0
  - multiple occurrences of elements in array can occur

E
[2, 12, 8, 4, 6] -> sum: 32
nearest prime: 37
return: 37 - 32 = 5

D
- need to sum nums in array
- need to check for prime nums
- need to find difference between next prime num and sum

A
1. find sum of elements in input
2. starting at next num from sum found in step 1, check for prime nums
3. once prime is found, return difference between this and the sum from step 1

C
=end

=begin
P
input: num
output: boolean based on whether input is prime

E
49
divisible by:
2: no
3: no
4: no
5: no
6: no
7: yes -> return false

37
divisible by:
2: no
3: no
4: no
5: no
6: no
7: greater than sqrt of 37 -> return true

D
- need to check nums from 2 just up to sqrt of input
- need to check whether input is divisible by each num

A
1. find max divisor to iterate to by taking sqrt of input and round down
2. iterate from 2 up to max divisor
  2a. for each num, determine if multiple
  2b. if multiple, immediately return false
3. if iteration complete, return true

C
=end

def prime?(num)
  max_divisor = Math.sqrt(num).floor

  2.upto(max_divisor) { |divisor| return false if (num % divisor).zero? }
  true
end

def nearest_prime_sum(nums)
  current_sum = nums.sum
  prime_sum = current_sum + 1

  loop do
    break if prime?(prime_sum)

    prime_sum += 1
  end

  prime_sum - current_sum
end

p nearest_prime_sum([1, 2, 3]) == 1        # Nearest prime to 6 is 7
p nearest_prime_sum([5, 2]) == 4           # Nearest prime to 7 is 11
p nearest_prime_sum([1, 1, 1]) == 2        # Nearest prime to 3 is 5
p nearest_prime_sum([2, 12, 8, 4, 6]) == 5 # Nearest prime to 32 is 37

# Nearest prime to 163 is 167
p nearest_prime_sum([50, 39, 49, 6, 17, 2]) == 4
