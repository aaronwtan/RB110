=begin
P
input: non-empty string, s
output: array with first element being a string, t, and second element being an integer, k
  - s, t, and k are related such that s == t * k, i.e. input string is a copy of output string multiplied by integer k
  - string t should be the shortest possible substring
  - integer k should be the largest possible repeat count for t to be equal s
  - input will be always be lowercase
  - if no repeated substrings satisfy requirements, str output should have the same
    value as input and integer output should be 1

E
'abcabc' -> abc * 2
'aaaaa' -> a * 5

D
- String#* can be used to multiply substr to check if multiple copies will be equal to input
- only up to half of the input string needs to be checked; past that point, only possibility
  is k == 1
example: ababab
  - a multiplied by 6 to get same length
  - ab multiplied by 3 to get same length and match
super
  - s -> multiplied by 5 to get same length
  - su -> length is not multiple of input str length
  - reached halfway, so only possibility is t == super, k == 1
- any substr pattern must begin with first char of input
- can stop iterating at length of input str divided by 2 rounded down

A
1. iterate substrings beginning with first char of input for lengths 1 up to half of input str length
2. for each substr length
  2a. obtain a multiplier by dividing input str length by the current substr length
  2b. multiply current substr by multiplier
  2c. return array with current substr as first element and multiplier as 2nd element if
    multiplied substr matches input
3. if iteration completed without finding match, return array with input str and 1

C
=end

def repeated_substring(s)
  str_length = s.length
  max_substr_length = str_length / 2

  (1..max_substr_length).each do |current_substr_length|
    current_substr = s[0, current_substr_length]
    multiplier = str_length / current_substr_length
    next unless current_substr * multiplier == s

    t = current_substr
    k = multiplier
    return [t, k]
  end

  t = s
  k = 1

  [t, k]
end

p repeated_substring('xyzxyzxyz') == ['xyz', 3]
p repeated_substring('xyxy') == ['xy', 2]
p repeated_substring('xyz') == ['xyz', 1]
p repeated_substring('aaaaaaaa') == ['a', 8]
p repeated_substring('superduper') == ['superduper', 1]
