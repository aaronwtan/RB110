# String#upcase! is a destructive method, so why does this code print HEY you
# instead of HEY YOU? Modify the code so that it produces the expected output.

# def shout_out_to(name)
#   name.chars.each { |c| c.upcase! }

#   puts 'HEY ' + name
# end

# shout_out_to('you') # expected: 'HEY YOU'

# String#upcase! is a destructive method, but in this code it is being called
# on each element of name.chars. String#chars creates a new array from the
# characters of the given string, so calling a destructive method on the elements
# of this array will not alter the original string. For this method to produce
# the expected results, String#upcase! should be called directly on the
# name parameter.

def shout_out_to(name)
  name.upcase!

  puts 'HEY ' + name
end

shout_out_to('you') # expected: 'HEY YOU'
