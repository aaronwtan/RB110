# A UUID is a type of identifier often used as a way to uniquely identify items.

# Each UUID consists of 32 hexadecimal characters,
# and is typically broken into 5 sections like this 8-4-4-4-12 and represented as a string.

# It looks like this: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

# Write a method that returns one UUID when called with no parameters.


# PEDAC
# input: none
# output: string representing a UUID
# rules:
#  - UUID is a 16 character string organized into 5 sections like this: 8-4-4-4-12
#  - each character is a randomly generated hexadecimal character (1 2 3 4 5 6 7 8 9 a b c d e f)

# algorithm:
# - initialize empty string to store result
# - loop 8, 4, 4, 4, and 12 times for 5 sections of string
#   - generate random hexadecimal character and append to result string
# - join sections with dashes

# generate_hexa_string
# input: number of characters of string
# output: hexadecimal string of length given by input
# algorithm:
# - initialize result string
# - loop number of times given by input
#   - generate random hexadecimal character and append to result string

HEXADECIMALS = ('0'..'9').to_a + ('a'..'f').to_a

def generate_hexa_string(num_of_chars)
  (1..num_of_chars).map { |_| HEXADECIMALS.sample }.join
end

def generate_uuid
  [8, 4, 4, 4, 12].map { |section_length| generate_hexa_string(section_length) }.join('-')
end

p generate_uuid
