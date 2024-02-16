# The following code:
# def my_method(array)
#   if array.empty?
#     []
#   elsif
#     array.map do |value|
#       value * value
#     end
#   else
#     [7 * array.first]
#   end
# end

def my_method(array)
  if array.empty?
    []
  elsif array.size > 1
    array.map do |value|
      value * value
    end
  else
    [7 * array.first]
  end
end

p my_method([])
p my_method([3])
p my_method([3, 4])
p my_method([5, 6, 7])

# is expected to print:
# []
# [21]
# [9, 16]
# [25, 36, 49]

# However, it does not. Obviously, there is a bug. Find and fix the bug,
# then explain why the buggy program printed the results it did.

# The condition of the elsif branch is the return value of calling #map
# on the array parameter. #map always returns an array, which is a
# truthy value, so the elsif branch will always be executed regardless
# of what argument is passed to my_method. The #map invocation (including
# the block passed) is treated as the condition, so since there
# is no other code within this elsif branch, its return value will always be nil.
# Therefore whenever any non-empty array is passed to my_method,
# this elsif branch will always be executed and return nil
