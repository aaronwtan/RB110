# 1. init nums_sum to 0 to hold sum of all string nums
# 2. init num_start_index starting at 0
# 3. Starting at num_start_index 0, check if current char represented is an integer
#   3a. if it is, init current_num_str to current char
#     - init num_end_index to num_start_index + 1
#     - check if char at num_end_index is an integer
#       - if it is, append to current_num_str
#       - increment num_end_index by 1
#     - if not, increment num_start_index by length of current_num_str
#         - add integer version of current_num_str to nums_sum
#   3b. if not, increment num_start_index by 1
# 4. Repeat step 3 until end of string
# 5. Return num_sums

def integer?(str)
  str.to_i.to_s == str
end

def sum_of_numbers(str)
  nums_sum = 0
  start_index = 0
  end_index = 0

  while start_index < str.length
    current_char = str[start_index]

    if integer?(current_char)
      end_index = start_index + 1
      current_num_str = current_char

      while end_index < str.length
        if integer?(str[end_index])
          current_num_str << str[end_index]
          end_index += 1
        else
          nums_sum += current_num_str.to_i
          start_index += current_num_str.length
          break
        end
      end
    else
      start_index += 1
    end

    if end_index >= str.length
      nums_sum += current_num_str.to_i
      break
    end
  end

  nums_sum
end

p sum_of_numbers("L12aun3ch Sch3oo451") == 469
p sum_of_numbers("HE2LL3O W1OR5LD") == 11
p sum_of_numbers("The30quick20brown10f0x1203jumps914ov3r1349the102l4zy dog") == 3635
