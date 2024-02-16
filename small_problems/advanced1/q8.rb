# Sort an array of passed in values using merge sort. You can assume that
# this array may contain only one type of data.
# And that data may be either all numbers or all strings.

# Merge sort is a recursive sorting algorithm that works
# by breaking down the array elements into nested sub-arrays,
# then recombining those nested sub-arrays in sorted order. It is best shown
# by example. For instance, let's merge sort the array [9,5,7,1].
# Breaking this down into nested sub-arrays, we get:

# [9, 5, 7, 1] ->
# [[9, 5], [7, 1]] ->
# [[[9], [5]], [[7], [1]]]

# We then work our way back to a flat array by merging each pair
# of nested sub-arrays:

# [[[9], [5]], [[7], [1]]] ->
# [[5, 9], [1, 7]] ->
# [1, 5, 7, 9]

def merge_sort(arr)
  arr_size = arr.size

  return arr if arr_size == 1

  arr1 = arr[0...arr_size / 2]
  arr2 = arr[arr_size / 2..]

  arr1 = merge_sort(arr1)
  arr2 = merge_sort(arr2)

  merge(arr1, arr2)
end

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
p merge_sort([9, 5, 7, 1]) == [1, 5, 7, 9]
p merge_sort([5, 3]) == [3, 5]
p merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]
