=begin
P
input: string consisting entirely of numeric digits
output: greatest product of 4 consecutive digits in input str
  - input will always have more than 4 digits
  - output will be an integer

E
'123987654'
possible sequences of 4 consecutive digits starting at index
0: 1239
1: 2398
2: 3987
3: 9876
4: 8765
5: 7654
greatest product from: 9*8*7*6 => 3024

D
- need to find all possible sequences of 4 consecutive digits
- need to convert digits to integers
- need to multiply nums of each sequence to find max product
- lead index will go from start of str up to 4th from end of str

A
1. init max product to 0 to hold the max product found
2. iterate start indices from 0 up to the length of input - 4
  2a. for each start index, take slice of string at current start index and length 4
  2b. split slice into individual digit chars
  2c. convert each digit into an integer
  2d. find product of digits
  2e. compare product to max product and reassign if greater
3. return max product

C
=end
# def greatest_product(num_str)
#   max_product = 0
#   max_start_index = num_str.length - 4

#   (0..max_start_index).each do |start_index|
#     sequence = num_str[start_index, 4]
#     digits = sequence.chars.map(&:to_i)
#     product = digits.reduce(&:*)
#     max_product = product if product > max_product
#   end

#   max_product
# end

def greatest_product(num_str)
  products = []
  max_start_index = num_str.length - 4

  (0..max_start_index).each do |start_index|
    sequence = num_str[start_index, 4]
    product = sequence.chars.reduce(1) { |prod, char| prod * char.to_i }
    products << product
  end

  products.max
end

p greatest_product('23456') == 360      # 3 * 4 * 5 * 6
p greatest_product('3145926') == 540    # 5 * 9 * 2 * 6
p greatest_product('1828172') == 128    # 1 * 8 * 2 * 8
p greatest_product('123987654') == 3024 # 9 * 8 * 7 * 6
