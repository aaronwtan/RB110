# Our countdown to launch isn't behaving as expected. Why?
# Change the code so that our program successfully counts down from 10 to 1.

# def decrease(counter)
#   counter -= 1
# end

# counter = 10

# 10.times do
#   puts counter
#   decrease(counter)
# end

# puts 'LAUNCH!'


# The counter parameter within the decrease method is reassigned with -= so
# that it does not change the value of the counter variable outside of the method.
# puts counter will therefore always output 10. Furthermore, integers are immutable,
# so there is actually no way to alter the outer counter variable from within a method.
# The return value of decrease would have to be reassigned to the outer counter variable

def decrease(counter)
  counter -= 1
end

counter = 10

10.times do
  puts counter
  counter = decrease(counter)
end

puts 'LAUNCH!'

# Further Exploration
10.downto(1) { |counter| puts counter }

puts 'LAUNCH!'
