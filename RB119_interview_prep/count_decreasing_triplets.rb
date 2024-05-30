=begin
P
input: array of numbers
output: integer that represent count of every combination of 3 nums are in decreasing order
  - order that nums are in array matters
  - if no combinations of 3 descending nums return 0

E
[5, 4, 3, 2, 1]
break into subarray combos of size 3
  [5, 4, 3], [5, 4, 2], [5, 4, 1], [5, 3, 2], [5, 3, 1], [5, 2, 1],
  [4, 3, 2], [4, 3, 1], [4, 2, 1],
  [3, 2, 1]

D
- need to generate subarrays of size 3
- need to increment first index, then check if subsequent elements are less than this element
for [2, 5, 3, 1]
  starting at index 2:
    - 5 > 2 not valid for next element
    - 3 > 2 not valid for next element
    - 1 < 2 valid
      - reached end of str
  starting at 5:
    - 3 < 5 valid for next element
    - 1 < 5 valid for next element
      - size 3 subarr found



A
0. init decreasing_trip_count to count num of decreasing triplets
1. increment from start index 0 up to 3rd to last index of input array
2. for each start index:
  2a. init current subarr to hold current subarr, starting with element at start index
  2b. check if element at next index is less than 1st element
    - if so, check if last element is less than 2nd element
      - if so, increment decreasing_trip_count by 1
      - otherwise, continue to next start index
    - otherwise, continue to next start index
3. return count of decreasing triplets

C
=end

# Given an array of numbers, return the count of all combination of 3 numbers where the values are in decreasing order.  -- Aaron

# def count_decreasing_triplets(nums)
#   decreasing_trip_count = 0
#   initial_first_index = 0
#   max_first_index = nums.length - 3

#   (initial_first_index..max_first_index).each do |first_index|
#     first_num = nums[first_index]

#     initial_second_index = first_index + 1
#     max_second_index = nums.length - 2
#     second_num = nums[initial_second_index]

#     next unless second_num < first_num

#     (initial_second_index..max_second_index).each do |second_index|
#       second_num = nums[second_index]

#       initial_third_index = second_index + 1
#       max_third_index = nums.length - 1

#       (initial_third_index..max_third_index).each do |third_index|
#         third_num = nums[third_index]
#         decreasing_trip_count += 1 if third_num < second_num
#       end
#     end
#   end

#   decreasing_trip_count
# end

def count_decreasing_triplets(nums)
  trip_count = 0

  initial_first_index = 0
  max_first_index = nums.size - 3

  initial_second_index = 1
  max_second_index = nums.size - 2

  initial_third_index = 2
  max_third_index = nums.size - 1

  (initial_first_index..max_first_index).each do |first_index|
    first_num = nums[first_index]

    (initial_second_index..max_second_index).each do |second_index|
      second_num = nums[second_index]
      next unless second_num < first_num

      (initial_third_index..max_third_index).each do |third_index|
        third_num = nums[third_index]
        next unless third_num < second_num

        trip_count += 1
      end
    end
  end

  trip_count
end

# def count_decreasing_triplets(arr)
#   count = 0

#   (0...arr.length - 2).each do |i|
#     (i + 1...arr.length - 1).each do |j|
#       (j + 1...arr.length).each do |k|
#         count += 1 if arr[i] > arr[j] && arr[j] > arr[k]
#       end
#     end
#   end
#   count
# end

# Test cases
puts count_decreasing_triplets([5, 4, 3, 2, 1]) # Expected output: 10
puts count_decreasing_triplets([-1, -2, -3, 4]) # Expected output: 1
puts count_decreasing_triplets([1, 2, 3, 4, 5]) # Expected output: 0 (No combinations)
