# Write a method that takes two sorted Arrays as arguments,
# and returns a new Array that contains all elements from both arguments in sorted order.

# You may not provide any solution that requires you to sort the result array.
# You must build the result array one element at a time in the proper order.

# Your solution should not mutate the input arrays.

def merge(arr1, arr2)
  result = []
  merged_arr = arr1 + arr2

  merged_arr.size.times do
    min_element = merged_arr.min
    merged_arr.count(min_element).times { result << min_element }
    merged_arr.delete(min_element)
  end

  result
end

# Examples:
p merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
p merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
p merge([], [1, 4, 5]) == [1, 4, 5]
p merge([1, 4, 5], []) == [1, 4, 5]
