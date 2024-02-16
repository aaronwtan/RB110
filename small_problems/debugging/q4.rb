# The reverse_sentence method should return a new string with the words
# of its argument in reverse order, without using any of Ruby's
# built-in reverse methods. However, the code below raises an error.
# Change it so that it behaves as expected.

# def reverse_sentence(sentence)
#   words = sentence.split(' ')
#   reversed_words = []

#   i = 0
#   while i < words.length
#     reversed_words = words[i] + reversed_words
#     i += 1
#   end

#   reversed_words.join(' ')
# end

def reverse_sentence(sentence)
  words = sentence.split(' ')
  reversed_words = []

  i = words.length - 1
  while i >= 0
    reversed_words << words[i]
    i -= 1
  end

  reversed_words.join(' ')
end

p reverse_sentence('how are you doing')
# expected output: 'doing you are how'
