# PEDAC Method practice

def sum_even_number_row(row_number)
  rows = []
  start_integer = 2

  (1..row_number).each do |current_row_number|
    rows << create_row(start_integer, current_row_number)
    start_integer = rows.last.last + 2
  end

  rows.last.sum
end

def create_row(start_integer, row_length)
  row = []
  current_integer = start_integer

  loop do
    row << current_integer
    current_integer += 2
    break if row.length >= row_length
  end

  row
end

# Examples:
p sum_even_number_row(1) == 2
p sum_even_number_row(2) == 10
p sum_even_number_row(4) == 68

# Examples:
# p create_row(2, 1) == [2]
# p create_row(4, 2) == [4, 6]
# p create_row(8, 3) == [8, 10, 12]
