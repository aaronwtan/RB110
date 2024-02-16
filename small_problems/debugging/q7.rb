# We wrote a neutralize method that removes negative words from sentences.
# However, it fails to remove all of them. What exactly happens?

# def neutralize(sentence)
#   words = sentence.split(' ')
#   words.each do |word|
#     words.delete(word) if negative?(word)
#   end

#   words.join(' ')
# end

# def negative?(word)
#   [ 'dull',
#     'boring',
#     'annoying',
#     'chaotic'
#   ].include?(word)
# end

# puts neutralize('These dull boring cards are part of a chaotic board game.')
# Expected: These cards are part of a board game.
# Actual: These boring cards are part of a board game.

# The words array is being mutated as it is iterated over with the Array#each
# call on line 3. This can be avoided by either storing the result in a new
# separate array, or by using a filtering method like Array#select or Array#reject

def neutralize(sentence)
  words = sentence.split(' ')
  words.reject! do |word|
    negative?(word)
  end

  words.join(' ')
end

def negative?(word)
  [ 'dull',
    'boring',
    'annoying',
    'chaotic'
  ].include?(word)
end

puts neutralize('These dull boring cards are part of a chaotic board game.')
# Expected: These cards are part of a board game.
# Actual: These boring cards are part of a board game.
