# Given this data structure write some code to return an array
# which contains only the hashes where all the integers are even.
arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

new_arr = arr.select do |hsh|
  hsh.values.all? do |sub_arr|
    sub_arr.all?(&:even?)
  end
end

p new_arr
