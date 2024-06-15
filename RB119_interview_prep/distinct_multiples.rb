=begin
P
input: str
output: count of distinct case-insensitive alphanumeric chars of str that occur more than once
  - input will always contain alphanumeric chars
  - counts are case-insensitive
  - return 0 if no chars occur more than once

E
'xXyYpzZr7657' lowercase -> "xxyypzzr7657"
uniq counts
x: 2
y: 2
p: 1
z: 2
r: 1
7: 2
6: 1
5: 1
final return: 4

D
- need count unique chars of input
- need to count as distinct multiple if count > 1
- need to work with downcased str

A
1. convert input to downcased version
2. find uniq chars of downcased input
3. iterate through uniq chars and find count of each char in input
4. count how many of counts in step 3 > 1 and return this count

C
=end

def distinct_multiples(str)
  downcased_str = str.downcase
  uniq_chars = downcased_str.chars.uniq

  uniq_chars.count { |char| downcased_str.count(char) > 1 }
end

p distinct_multiples('xyz') == 0               # (none
p distinct_multiples('xxyypzzr') == 3          # x, y, z
p distinct_multiples('xXyYpzZr') == 3          # x, y, z
p distinct_multiples('unununium') == 2         # u, n
p distinct_multiples('multiplicity') == 3      # l, t, i
p distinct_multiples('7657') == 1              # 7
p distinct_multiples('3141592653589793') == 4  # 3, 1, 5, 9
p distinct_multiples('2718281828459045') == 5  # 2, 1, 8, 4, 5
p distinct_multiples('xXyYpzZr7657')
