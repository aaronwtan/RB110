# def even_subs(arr_int)
#   all_subs = []
#   max_range = arr_int.size
#   arr_int.size.times do |start|
#     1.upto(max_range) do |length|
#       all_subs << arr_int[start, length]
#     end

#     max_range -= 1
#   end
  
#   selected = all_subs.select do |sub|
#     sub.sum.even?
#   end

#   selected.uniq
# end

=begin
Given a collection of integers, write a method to return a new collection
of every unique contiguous subarray in that collection with an even sum.
The returned subarrays can be in any order.

PROBLEM
- input: array of integers
- output: new 2D array of each unique contiguous subarray in the given array
          with an even subarray
  
- explicit requirements:
  - subarrays are contiguous, i.e. each element is in the exact sequence as in the
    complete array
  - subarrays are unique
  - elements of subarrays have an even sum
  - subarrays can be in any order
- implicit requirements:

EXAMPLES
given: [1, 2, 3, 4, 5]

subarrays starting with:

1
[1] -> 1 (not even sum)
[1, 2] -> 3 (not even)
[1, 2, 3] -> 6 (EVEN)
[1, 2, 3, 4] -> 10 (EVEN)
[1, 2, 3, 4, 5] -> 15 (not even)

2
[2] -> 2 (EVEN)
[2, 3] -> 5 (not even)
[2, 3, 4] -> 9 (not even)
[2, 3, 4, 5] -> 14 (EVEN)

3
[3] -> 3 (not even)
[3. 4] -> 7 (not even)
[3, 4, 5] -> 12 (EVEN)

4
[4] -> 4 (EVEN)
[4, 5] -> 9 (not even)

5
[5] -> (not even)

example output: [[1, 2, 3], [1, 2, 3, 4], [2], [2, 3, 4, 5], [3, 4, 5], [4]]

DATA STRUCTURE
- subarrays with starting index as each element of the given array
- for each set of subarrays with a given starting index, size of subarrays
  range from the starting index until the end of the array

ALGORITHM
1. initialize result array
2. iterate over given array
   - for each element, starting at index of current element:
     - initialize empty subarray
     - starting at index of current element, push elements of subsequent indices
        into subarray
     - push subarray into result array if sum of elements is even
     - break after end of array is reached
3. return result array

CODE
=end

def even_subs(arr)
  result = []

  arr.each_index do |start_index|
    start_index.upto(arr.size - 1) do |end_index|
      subarr = arr[start_index..end_index]
      result << subarr if subarr.sum.even?
    end
  end

  result.uniq
end

p even_subs([1, 1, 1, 1, 1]).sort == [[1, 1], [1, 1, 1, 1]]
p even_subs([1, 2, 3, 4, 5]).sort == [[1, 2, 3], [1, 2, 3, 4], [2], [2, 3, 4, 5], [3, 4, 5], [4]]
p even_subs([88, 54, 67, 56, 36]).sort == [[36], [54], [56], [56, 36], [88], [88, 54]]