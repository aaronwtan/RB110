=begin
P
input: array of numbers
output: array where each element is a count of how many others numbers
  are smaller than the corresponding number
  - duplicate numbers are not counted
  - for 1-element arrays, return array with element 0

E
[1, 2, 3] -> [0, 1, 2]
[1, 1, 2, 2, 3, 3] -> [0, 0, 1, 1, 2, 2]

D
array

A
1. generate unique array of given integers using #uniq and assign to uniq_nums
2. iterate through integers using #map
  - for each integer,
    - iterate through uniq_nums and count how many are less than current integers
    - return this count to block to be used by #map

C
=end

def smaller_numbers_than_current(numbers)
  uniq_nums = numbers.uniq

  numbers.map do |current_num|
    uniq_nums.count { |uniq_num| uniq_num < current_num }
  end
end

p smaller_numbers_than_current([8, 1, 2, 2, 3]) == [3, 0, 1, 1, 2]
p smaller_numbers_than_current([7, 7, 7, 7]) == [0, 0, 0, 0]
p smaller_numbers_than_current([6, 5, 4, 8]) == [2, 1, 0, 3]
p smaller_numbers_than_current([1]) == [0]

my_array = [1, 4, 6, 8, 13, 2, 4, 5, 4]
result   = [0, 2, 4, 5, 6, 1, 2, 3, 2]
p smaller_numbers_than_current(my_array) == result
