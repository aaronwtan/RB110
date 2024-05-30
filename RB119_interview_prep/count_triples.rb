# Write a function that returns the count of triples of numbers that have 2 odd numbers and 1 even.
# If there’s none return -1. All numbers in the array will be integers greater than 0.

=begin
P
input: array of nums
output: integer representing the number of triples of input that have 2 odd nums and 1 even
  - triple is any combination of 3 numbers
  - same 3 numbers in different order is counted as the same triple
  - if no triples present (meaning less than 2 odds and/or less than 1 even), return -1
  - all nums in input will be integers > 0

E
[1, 2, 3, 4, 5, 6]
odds: 1, 3, 5
combos of 2 odds: 1, 3
                  1, 5
                  3, 5
possible 1st odd index range: 0..(num of odds - 2)
possible 2nd odd index range: (first odd index + 1)..(num of odds - 1)

evens: 2, 4, 6
num of combos of 2 odds: 3
num of evens: 3
return: 3 * 3


D
- need to find how many combinations of 2 odd nums there are in input
- need to find num of evens
- multiply these to find result
- if less than 2 odds and/or no evens, can return -1 immediately

A
1. separate odds and evens in input
2. count num of odds and evens
3. if num of odds is less than 2 or num of evens is less than 1, return -1
4. init two odds count to 0 to count the num of 2 odd combos
5. iterate 1st odd index from 0 to (num of odds - 2)
  5a. for each 1st odd index, iterate 2nd odd index from (1st odd index + 1) to (num of odds - 1)
    - increment two odds count by 1
6. multiply num of odd combos by num of evens and return

C
=end

def count_triples(nums)
  odds, evens = nums.partition {|num| num.odd? }

  odds_count = odds.size
  evens_count = evens.size

  return -1 if odds_count < 2 || evens_count < 1

  two_odds_count = 0

  (0..odds_count - 2).each do |first_odd_index|
    two_odds_count += odds_count - first_odd_index - 1
  end

  two_odds_count * evens_count
end

# Test cases
p count_triples([1, 2, 3, 4]) # Expected output: 2
p count_triples([2, 4, 6, 8]) # Expected output: -1
p count_triples([1, 3, 5, 7]) # Expected output: -1
p count_triples([1, 2, 3, 4, 5, 6]) # Expected output: 9

def count_triples(arr)
  count = 0

  (0...arr.length - 2).each do |i|
      (i + 1...arr.length - 1).each do |j|
          (j + 1...arr.length).each do |k|
              odd_count = [arr[i], arr[j], arr[k]].count(&:odd?)
              count += 1 if odd_count == 2
          end
      end
  end

  count > 0 ? count : -1
end
