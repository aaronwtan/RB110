# Given the following data structure and without modifying the original array,
# use the map method to return a new array identical in structure
# to the original but where the value of each integer is incremented by 1.
arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

new_arr = arr.map do |sub_hsh|
  sub_hsh.each_with_object({}) do |(key, value), new_hsh|
    new_hsh[key] = value + 1
  end
end

# The return value from map should be the following array:
p new_arr == [{a: 2}, {b: 3, c: 4}, {d: 5, e: 6, f: 7}]
p arr == [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]
