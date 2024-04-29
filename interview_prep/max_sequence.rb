=begin
P
input: array of integers
output: max sum possible from given array with following constraints:
  - sum is generated from contiguous subsequence of given array
  - if given array is empty or consists of only negative numbers, return 0 as sum

E
[1] -> sum: 1
[1, 2, 3] 
    subs: [1], [1, 2], ->[1, 2, 3]<-
          [2], [2, 3]
          [3]
          max sum: 6
[1, -1, 1]
    subs: [1], [1, -1], [1, -1, 1]
          [-1], [-1, 1]
          [1]
          max sum: 1

D
array of possible subsequences

A
1. return 0 if empty array or array contains all negative numbers
2. init max sum variable to 0
3. generate array of subsequences (extracted to submethod)
4. iterate through array of subsequences
  - for each subsequence:
    - calculate sum of subsequence
    - if greater than current value of max sum, reassign to max sum
    - otherwise, proceed to next subsequence
5. return max sum
=end

=begin

#subsequences submethod
P
input: array of integers
output: array of every subsequence of given array

E
[1] -> [1]
[1, 2, 3] 
    subs: [1], [1, 2], [1, 2, 3]
          [2], [2, 3]
          [3]

D
array of subarrays representing subsequences of integers in given array

A
1. init result variable to empty array
2. iterate through given array
  - starting at index of current element:
    - append subarrays to result array,
    starting at length 1 until (length of given array - current index)
3. return result array of subsequences


=end

def max_sequence(array)
  return 0 if array.empty? || array.all?(&:negative?)

  max_sum = 0

  subarrays = subsequence(array)

  subarrays.each do |subarray|
    sub_sum = subarray.sum
    max_sum = sub_sum if sub_sum > max_sum
  end

  max_sum
end

def subsequence(array)
  result = []

  array.each_index do |index|
    0.upto(array.size - index) do |subarr_length|
      result << array[index, subarr_length]
    end
  end

  result
end

p max_sequence([]) == 0
p max_sequence([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6
p max_sequence([11]) == 11
p max_sequence([-32]) == 0
p max_sequence([-2, 1, -7, 4, -10, 2, 1, 5, 4]) == 12
