=begin
P
input: integer
output: sum of all nums less than input that are multiples of 7 or 11
  - if input is negative, return 0
  - if a num is a multiple of both 7 and 11, count it just once for summing
  - the input itself is not included for the output sum

E
21
mult of 7: 7, 14
mult of 11: 11
sum: 7 + 14 + 11 = 33

D
- need to look at all nums below argument checking for mult of 7 or 11
- can also just check mult of 7 or 11

A
0. return 0 if input <= 7
1. init sum to hold sum of mult
2. iterate from 7 to input - 1
  2a. if current num is a multiple of 7 or 11 (taking current num % 7 or 11 is 0)
    - increment sum by current num
3. return sum

C
=end


def seven_eleven(num)
  return 0 if num <= 7

  sum = 0

  (7...num).each do |current_num|
    sum += current_num if (current_num % 7 == 0) || (current_num % 11 == 0)
  end

  # faster solution
  # mult_of_seven = 7
  # mult_of_eleven = 11

  # while mult_of_seven < num
  #   sum += mult_of_seven
  #   mult_of_seven += 7
  # end

  # while mult_of_eleven < num
  #   sum += mult_of_eleven unless mult_of_eleven % 7 == 0
  #   mult_of_eleven += 11
  # end

  sum
end

p seven_eleven(10) == 7
p seven_eleven(11) == 7
p seven_eleven(12) == 18
p seven_eleven(25) == 75
p seven_eleven(100) == 1153
p seven_eleven(0) == 0
p seven_eleven(-100) == 0

p seven_eleven(1000000000)
