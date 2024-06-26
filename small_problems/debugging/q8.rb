# The following code prompts the user to set their own password if they haven't done so already,
# and then prompts them to login with that password. However, the program throws an error.
# What is the problem and how can you fix it?

# Once you get the program to run without error, does it behave as expected?
# Verify that you are able to log in with your new password.

# password = nil

# def set_password
#   puts 'What would you like your password to be?'
#   new_password = gets.chomp
#   password = new_password
# end

# def verify_password
#   puts '** Login **'
#   print 'Password: '
#   input = gets.chomp

#   if input == password
#     puts 'Welcome to the inside!'
#   else
#     puts 'Authentication failed.'
#   end
# end

# if !password
#   set_password
# end

# verify_password

# The verify_password method does not have access to the password variable initialized
# on line 1 since methods have their own self-contained scope. This can be fixed
# by rewriting the method to take a parameter and then passing password into the method
# as an argument

password = nil

def set_password
  puts 'What would you like your password to be?'
  gets.chomp
end

def verify_password(password)
  puts '** Login **'
  print 'Password: '
  input = gets.chomp

  if input == password
    puts 'Welcome to the inside!'
  else
    puts 'Authentication failed.'
  end
end

if !password
  password = set_password
end

verify_password(password)
