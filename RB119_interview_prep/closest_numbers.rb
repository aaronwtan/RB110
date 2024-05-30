=begin
P
input: array of integers
output: array of 2 integers that are closest together in value
  - output integers do not have to be next to each other in position
  - if multiple pairs are equally close, return pair that occurs first in array
    - when checking which pair occurs first, check order of 1st element first, then 2nd

E
[1, 2, 4, 7]
    -> 2 num subarrays:
    [1, 2], [1, 4], [1, 7],
    [2, 4], [2, 7],
    [4, 7]
    smallest difference value: 1 for subarray [1, 2]

D
array of subarrays representing all possible 2 integer combos excluding duplicates

A
1. generate array of subarrays of size 2 using a helper method
2. iterate through subarrays and to find min value difference and return corresponding subarray

C
=end

=begin
#two_num_subarrays
P
input: array of nums
output: array of every subarray of 2 nums excluding duplicates

E
[1, 2, 4, 7]
    -> 2 num subarrays:
    [1, 2], [1, 4], [1, 7],
    [2, 4], [2, 7],
    [4, 7]

D
array of subarrs

A
1. init result to empty array
2. iterate from first num index 0 to (size of arr - 2) 
    - for each first num index:
      - iterate from second num index (first num index + 1) to final index of given array
        for each second num index:
        - create subarr with nums at current first and second num indices
        - append subarr to result
3. return result

C

=end

def two_num_subarrays(nums)
  result = []
  max_first_num_index = nums.size - 2

  (0..max_first_num_index).each do |first_num_index|
    max_second_num_index = nums.size - 1

    (first_num_index + 1..max_second_num_index).each do |second_num_index|
      subarr = [nums[first_num_index], nums[second_num_index]]
      result << subarr
    end
  end

  result
end

def closest_numbers(nums)
  subarrs = two_num_subarrays(nums)

  subarrs.min_by { |subarr| subarr.max - subarr.min }
end

p closest_numbers([5, 25, 15, 11, 20]) == [15, 11]
p closest_numbers([19, 25, 32, 4, 27, 16]) == [25, 27]
p closest_numbers([12, 22, 7, 17]) == [12, 7]

# alternate solution without using #min_by

# def closest_numbers(nums)
#   result = []
#   min_difference = nums.max - nums.min

#   max_first_num_index = nums.size - 2

#   (0..max_first_num_index).each do |first_num_index|
#     max_second_num_index = nums.size - 1

#     (first_num_index + 1..max_second_num_index).each do |second_num_index|
#       first_num = nums[first_num_index]
#       second_num = nums[second_num_index]

#       current_nums = [first_num, second_num]
#       current_difference = (first_num - second_num).abs

#       if current_difference < min_difference
#         min_difference = current_difference
#         result = current_nums
#       end
#     end
#   end

#   result
# end
