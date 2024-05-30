=begin
P
input: grid of values represented by an array of arrays where each subarr is a row
output: largest sum of column of values of input
  - column values have the same position in each subarr
  - assuming values are all positive integers from test cases

E
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
col: 1  2  3
sum: 12 15 18
largest sum: 18


D
- need to iterate through indices of subarrs from 0 to length of subarr
- row index represents subarr position in overall grid
- column index represents positions of elements in individual subarrs
- all subarrs will have the same length
- need to iterate through all subarrs at each column index
  to collect values of subarrs at each column index and sum them up
- need to compare sums to find largest sum

A
1. init largest sum to 0 hold the largest column sum found
2. find max column index by taking length of any subarr - 1
3. find max row index by counting number of subarrs - 1
4. iterate through columns starting from column index 0 to max column index
  4a. for each column index, init a current column sum to 0 to hold sum of current column
  4b. iterate through rows starting from row index 0 to max row index
    4ba. for each row index, increment current column sum by value at current row and column index
  4c. after rows have been iterated through for current column, compare column sum to largest column sum and reassign if larger
5. return largest column sum

C
=end

def largest_column(grid)
  largest_sum = 0
  max_column_index = grid.first.length - 1
  max_row_index = grid.length - 1

  (0..max_column_index).each do |column_index|
    current_column_sum = 0

    (0..max_row_index).each do |row_index|
      current_column_sum += grid[row_index][column_index]
    end

    largest_sum = current_column_sum if current_column_sum > largest_sum
  end

  largest_sum
end

=begin
Given a grid of values represented by an array of arrays, e.g.:
[1, 2, 3],
[4, 5, 6],
[7, 8, 9]

Return the largest sum of a column of values in the grid.
In this example, the largest sum is 18.
=end
a = [[1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]]

p largest_column(a) == 18

b = [[1, 2, 3, 4],
    [5, 6, 7, 8]]
    
p largest_column(b) == 12

c = [[1, 0, 0],
     [5, 8, 10],
     [3, 5, 1]]
     
p largest_column(c) == 13
