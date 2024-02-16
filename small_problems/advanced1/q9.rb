# A Rational Number is any number that can be represented as the result
# of the division between two integers, e.g., 1/3, 3/2, 22/7, etc.
# The number to the left is called the numerator, and the number
# to the right is called the denominator.

# A Unit Fraction is a rational number where the numerator is 1.

# An Egyptian Fraction is the sum of a series of distinct unit fractions
# (no two are the same), such as:

# 1   1    1    1
# - + - + -- + --
# 2   3   13   15

# Every positive rational number can be written as an Egyptian fraction.
# For example:

#     1   1   1   1
# 2 = - + - + - + -
#     1   2   3   6

# Write two methods: one that takes a Rational number as an argument,
# and returns an Array of the denominators that are part
# of an Egyptian Fraction representation of the number, and another
# that takes an Array of numbers in the same format, and calculates
# the resulting Rational number. You will need to use the Rational class
# provided by Ruby.

def egyptian(rational)
  result = []
  remainder = rational
  denominator = 1

  until remainder.zero?
    current_unit_fraction = Rational(1, denominator)

    if current_unit_fraction <= remainder
      result << denominator
      remainder -= current_unit_fraction
    end

    denominator += 1
  end

  result
end

def unegyptian(denominators)
  denominators.map { |denominator| Rational(1, denominator) }.sum
end

# Examples:
p egyptian(Rational(2, 1))    # -> [1, 2, 3, 6]
p egyptian(Rational(137, 60)) # -> [1, 2, 3, 4, 5]
p egyptian(Rational(3, 1))    # -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 230, 57960]

p unegyptian(egyptian(Rational(1, 2))) == Rational(1, 2)
p unegyptian(egyptian(Rational(3, 4))) == Rational(3, 4)
p unegyptian(egyptian(Rational(39, 20))) == Rational(39, 20)
p unegyptian(egyptian(Rational(127, 130))) == Rational(127, 130)
p unegyptian(egyptian(Rational(5, 7))) == Rational(5, 7)
p unegyptian(egyptian(Rational(1, 1))) == Rational(1, 1)
p unegyptian(egyptian(Rational(2, 1))) == Rational(2, 1)
p unegyptian(egyptian(Rational(3, 1))) == Rational(3, 1)
