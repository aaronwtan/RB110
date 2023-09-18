# Using the each method, write some code to output all of the vowels from the strings.
hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

VOWELS = 'aeiouAEIOU'.freeze

hsh.each do |_, words|
  words.each do |word|
    word.each_char do |char|
      puts char if VOWELS.include?(char)
    end
  end
end
