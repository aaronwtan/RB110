=begin
P
input: string of digits
output: integer representing number of substrings of given string that represent an even num
  - if any substring occurs more than once, count each as separate substr
  - if no even substrings found, return 0

E
'123'
substr: '1', '12' '123'
        '2', '23'
        '3'
even subs: 2

D
array of every substring to locate even substrings

A
1. generate array of substrings of given str using helper method and assign to substrings array
2. iterate through substrings array
  - for each substring
    - convert substring to integer
    - if converted substring is even, count substr
    - otherwise proceed to next substr
3. return even substrings count after iteration is complete

C

#substrings method
P
input: string
output: array of substrings

E
'123'
substr: '1', '12' '123'
        '2', '23'
        '3'

D
array of substr

A
1. init result to empty array
2. iterate from start index 0 to last index of given str
  - for each start index
    - iterate from length 1 to length (str.length - current start index)
      - for each length
        - append substr with current start index and current length to result
3. return result

C
=end

def substrings(str)
  result = []

  str_length = str.length
  max_start_index = str.length - 1

  (0..max_start_index).each do |start_index|
    max_substr_length = str_length - start_index

    (1..max_substr_length).each do |substr_length|
      result << str[start_index, substr_length]
    end
  end

  result
end

def even_substrings(digits)
  substr_arr = substrings(digits)
  substr_arr.count { |substr| substr.to_i.even? }
end

p even_substrings('1432') == 6
p even_substrings('3145926') == 16
p even_substrings('2718281') == 16
p even_substrings('13579') == 0
p even_substrings('143232') == 12
