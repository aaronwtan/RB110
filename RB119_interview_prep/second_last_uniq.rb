# Given a string `s` find the second to last non-repeating character in it and return its index. 
# If it doesn't exist return -1. Consider lowercase and uppercase characters the same.

=begin
P
input: str 's'
output: index of the second to last non-repeating char in the input str
  - if no index satisfies condition, return -1
  - when looking for repeating chars, case-insensitive
  - repeating means at least 2 of char occurs within str

E
LaunchSchool -> launchschool
-> loohcshcnual -> l o h c s n u a
uniq chars count
l: 2
o: 2
h: 2
c: 2
s: 1 <- first count less than 2
n: 1 <- second count less than 2

return the index for 'n' where it occurs in the non-reversed downcase input -> 3

D
- need to work with downcased str
- need to reverse str
- need to uniq chars of reversed str
- need to count how many times each uniq char occurs
- need to keep track of 2nd time a char has a count of 1

A
1. convert input to downcased version
2. reverse the downcased str
3. break reversed str into uniq chars
4. iterate through uniq chars
  4a. init a boolean to keep track of whether a first non-repeating char has been found
  4b. count how many of each uniq char occurs in the downcased str
  4c. if count of uniq char is 1
    - if first non-repeating boolean is false, then switch true and proceed to the next uniq char
    - if true, return the index at which the current uniq char occurs in the original input downcased
5. if iteration completed without finding index return -1
C
=end

def second_last_uniq(s)
  downcased_str = s.downcase
  reversed_str = downcased_str.reverse
  uniq_chars = reversed_str.chars.uniq
  first_non_repeating_found = false

  uniq_chars.each do |char|
    next unless downcased_str.count(char) == 1
    return downcased_str.index(char) if first_non_repeating_found

    first_non_repeating_found = true
  end

  -1
end

p second_last_uniq("LaunchSchool") == 3
p second_last_uniq("SupercalifRagilISticexpialiDociOus") == 21
p second_last_uniq("aaBbccC") == -1
p second_last_uniq("aaBbc") == -1

# All test cases should print true