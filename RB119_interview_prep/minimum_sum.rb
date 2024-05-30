=begin
P
input: array of integers
output: integer representing min sum of 5 consecutive integers from given array
  - if given array has less than 5 elements, return nil

E
[] -> nil
[1] -> nil
[1, 2, 3, 4, 5] -> 10
[0, 0, 0, 0, 0, 0, 1]
  subarrays: [0, 0, 0, 0, 0] -> 0
             [0, 0, 0, 0, 1] -> 1
            min sum: 0

D
subarrays of size 5

A
1. return nil if array size is less than 5
2. generate array of subarrays of size 5 using helper method and assign to subarrays   
3. iterate through subarrays and return min sum

C
=end

=begin
#length_five_subarray
P
input: array of integers
output: array of subarrays of length 5 with consecutive elements

E
[0, 0, 0, 0, 0, 0, 1]
  subarrays: [0, 0, 0, 0, 0] -> 0
             [0, 0, 0, 0, 0] -> 0
             [0, 0, 0, 0, 1] -> 1

D
array

A
1. init result array to empty array
2. iterate starting index from 0 to (array size - 5)
  - for each starting index
    - append subarray with current starting index and length 5 to result
3. return result

C
=end

def length_five_subarray(nums)
  result = []

  (0..nums.size - 5).each do |start_index|
    result << nums[start_index, 5]
  end

  result
end

def minimum_sum(nums)
  return nil if nums.size < 5

  subarrays = length_five_subarray(nums)
  subarrays.min_by(&:sum).sum
end

p minimum_sum([1, 2, 3, 4]) == nil
p minimum_sum([1, 2, 3, 4, 5, -5]) == 9
p minimum_sum([1, 2, 3, 4, 5, 6]) == 15
p minimum_sum([55, 2, 6, 5, 1, 2, 9, 3, 5, 100]) == 16
p minimum_sum([-1, -5, -3, 0, -1, 2, -4]) == -10
