# As we saw in the previous exercises, a matrix can be represented in ruby by an Array of Arrays. For example:

# 1  5  8
# 4  7  2
# 3  9  6

# can be described by the Array of Arrays:

# matrix = [
#   [1, 5, 8],
#   [4, 7, 2],
#   [3, 9, 6]
# ]

# A 90-degree rotation of a matrix produces a new matrix in which each side
# of the matrix is rotated clockwise by 90 degrees. For example,
# the 90-degree rotation of the matrix shown above is:

# 3  4  1
# 9  7  5
# 6  2  8

# A 90 degree rotation of a non-square matrix is similar. For example, the rotation of:

# 3  4  1
# 9  7  5

# is:

# 9  3
# 7  4
# 5  1

# Write a method that takes an arbitrary matrix and rotates it 90 degrees clockwise as shown above.
def rotate90threebythree(matrix)
  [
    [matrix[2][0], matrix[1][0], matrix[0][0]],
    [matrix[2][1], matrix[1][1], matrix[0][1]],
    [matrix[2][2], matrix[1][2], matrix[0][2]]
  ]
end

def rotate90(matrix)
  result = []
  row_size = matrix[0].size
  column_size = matrix.size

  (0...row_size).each do |row_index|
    rotated_row = []

    (column_size - 1).downto(0) do |column_index|
      rotated_row << matrix[column_index][row_index]
    end

    result << rotated_row
  end

  result
end

# Examples
matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8]
]

new_matrix1 = rotate90(matrix1)
new_matrix2 = rotate90(matrix2)
new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))

p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]] # true
p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]] # true
p new_matrix3 == matrix2 # true

# Further Exploration
def rotate(matrix, angle)
  number_of_90rotations = angle / 90

  number_of_90rotations.times { matrix = rotate90(matrix) }

  matrix
end

new_matrix4 = rotate(matrix1, 90)
new_matrix5 = rotate(matrix2, 90)
new_matrix6 = rotate(rotate(rotate(rotate(matrix2, 90), 90), 90), 90)

p new_matrix4 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]] # true
p new_matrix5 == [[5, 3], [1, 7], [0, 4], [8, 2]] # true
p new_matrix6 == matrix2 # true

p rotate(matrix2, 180)
p rotate(matrix2, 270)
p rotate(matrix2, 360)
p rotate(matrix2, 450)
p rotate(matrix2, 540)
p rotate(matrix2, 630)
p rotate(matrix2, 720)
